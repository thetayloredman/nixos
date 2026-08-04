{ inputs, ... }:
{
  flake.modules.homeManager.profile-common-hm-full = {
    imports = with inputs.self.modules.homeManager; [
      zirco
      mfc
      neovim
      git
      shell
    ];

    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
