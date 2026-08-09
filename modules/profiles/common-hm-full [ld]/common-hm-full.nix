{ inputs, ... }:
{
  flake.modules.homeManager.profile-common-hm-full = {
    imports = with inputs.self.modules.homeManager; [
      nix
      zirco
      mfc
      neovim
      vscode
      git
      shell
    ];

    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
