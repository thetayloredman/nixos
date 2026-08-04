{ inputs, ... }: {
  flake.modules.homeManager.mfc =
    { pkgs, lib, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      mfcpkgs = inputs.mfc-pkgs.packages.${system};
    in
    {
      home.packages = [
        mfcpkgs.mfc
      ];
    };
}
