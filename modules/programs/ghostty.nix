{ ... }: {

  flake.modules.homeManager.ghostty = { pkgs, ... }: {
    programs.ghostty = {
      enable = true;
    };
  };
}
