{ inputs, ... }:
{
  flake.modules.homeManager.profile-devel = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      zirco
      neovim
      vscode
      git
      mfc
      resolvematrix
    ];
    home.packages = with pkgs; [ gh ];
  };

  flake.modules.nixos.profile-devel = {
    imports = with inputs.self.modules.nixos; [
      docker
    ];
  };
}
