# pending merge of https://github.com/NixOS/nixpkgs/pull/579858
{ inputs, ... }: {
  flake.modules.homeManager.matrix-rig =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.callPackage
          "${inputs.nixpkgs-thetayloredman-matrix-rig-init}/pkgs/by-name/ma/matrix-rig/package.nix"
          { }
        )
      ];
    };
}
