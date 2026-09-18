{ ... }: {
  flake.modules.nixos.fonts = { pkgs, lib, ... }: {
    fonts.packages =
      with pkgs;
      [ powerline-fonts ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    fonts.fontconfig.enable = true;
  };

  flake.modules.homeManager.fonts = { pkgs, lib, ... }: {
    config = lib.mkIf pkgs.stdenv.isDarwin {
      home.packages =
        with pkgs;
        [ powerline-fonts ]
        ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

      fonts.fontconfig.enable = true;
    };
  };
}
