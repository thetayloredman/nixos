{ inputs, ... }:
{
  flake.modules.homeManager.profile-devel = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      zirco
      neovim
      vscode
      git
      mfc
    ];
    home.packages = with pkgs; [
      gh
      matrix-rig
      resolvematrix
    ];
  };

  flake.modules.nixos.profile-devel = {
    imports = with inputs.self.modules.nixos; [
      docker
    ];
  };
}
