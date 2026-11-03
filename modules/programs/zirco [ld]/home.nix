{ inputs, ... }: {
  flake.modules.homeManager.zirco =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      zpkgs = inputs.zirco-pkgs.packages.${system};
    in
    {
      nix.settings = {
        extra-substituters = [ "https://zirco-lang.cachix.org" ];
        extra-trusted-public-keys = [
          "zirco-lang.cachix.org-1:yOFfIeYLXiX1bw09I3WnPWOBlBajwH3wYsPHlzwYDgc="
        ];
      };

      home.packages = with zpkgs; [
        zrc
        libzr
      ];
    };
}
