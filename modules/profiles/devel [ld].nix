{ inputs, ... }:
{
  flake.modules.homeManager.profile-devel = {
    imports = with inputs.self.modules.homeManager; [
      zirco
      neovim
      vscode
      git
    ];
  };

  flake.modules.nixos.profile-devel = {
    imports = with inputs.self.modules.nixos; [
      docker
    ];
  };
}
