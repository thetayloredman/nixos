# pending https://github.com/NixOS/nixpkgs/pull/554828
{ inputs, ... }: {
  flake.modules.homeManager.dcpomatic =
    { pkgs, ... }:
    let
      dcpomatic-pkgs = import inputs.logn-nixpkgs-dcpomatic-init {
        inherit (pkgs.stdenv.hostPlatform) system;
      };
    in
    {
      home.packages = [
        dcpomatic-pkgs.dcpomatic
      ];
    };
}
