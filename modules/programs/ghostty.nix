{ ... }: {

  flake.modules.homeManager.ghostty = { pkgs, ... }: {
    programs.ghostty = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    };
  };
}
