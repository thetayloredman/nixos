{ inputs, ... }: {
  flake.modules.homeManager.zirco =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      zpkgs = inputs.zirco-pkgs.packages.${system};
    in
    {
      home.packages = with zpkgs; [
        zrc
        libzr
      ];
    };
}
