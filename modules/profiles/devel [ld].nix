{ inputs, ... }:
{
  flake.modules.homeManager.profile-devel = {
    imports = with inputs.self.modules.homeManager; [
      zirco
      neovim
      vscode
      git
      mfc
      resolvematrix
    ];
  };

  flake.modules.nixos.profile-devel = {
    imports = with inputs.self.modules.nixos; [
      docker
    ];
  };
}
