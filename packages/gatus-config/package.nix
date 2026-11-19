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
    hostname: yamlFormat.generate "${hostname}.yaml" (import ./gatus/${hostname}.nix { inherit lib; });

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
