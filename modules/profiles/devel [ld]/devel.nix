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
}
