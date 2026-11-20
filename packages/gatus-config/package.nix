{
  lib,
  formats,
  runCommand,
}:

let
  hosts = [
    "hesdc"
    "borealis"
  ];

  yamlFormat = formats.yaml { };

  mkConfig =
    hostname:
    let
      generated = yamlFormat.generate "${hostname}.yaml" (
        import ./gatus/${hostname}.nix { inherit lib; }
      );
    in
    # Gatus shits itself when it sees a room ID with a ! prefix, so we jankily
    # sneak quotes in, since formats.yaml can't.
    runCommand "${hostname}-patched.yaml" { } ''
      sed -E 's|(internal-room-id: )(\$\{[^}]+\})|\1"\2"|' \
        ${generated} > $out
    '';

  configs = lib.genAttrs hosts (hostname: mkConfig hostname);

in

# We have to do it this way because flake-parts mandates there be a top-level derivation under
# packages.gatus-config.

runCommand "gatus-config"
  {
    passthru = configs;
  }
  ''
    mkdir -p $out
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (hostname: drv: ''
        ln -s ${drv} $out/${hostname}.yaml
      '') configs
    )}
  ''
