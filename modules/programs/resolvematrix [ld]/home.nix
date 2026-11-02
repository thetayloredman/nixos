# pending merge of https://github.com/NixOS/nixpkgs/pull/579474
{ inputs, ... }: {
  flake.modules.homeManager.resolvematrix =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.callPackage
          "${inputs.nixpkgs-thetayloredman-resolvematrix-init}/pkgs/by-name/re/resolvematrix/package.nix"
          { }
        )
      ];
    };
}
