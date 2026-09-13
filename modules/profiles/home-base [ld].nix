{ inputs, ... }:
{
  flake.modules.homeManager.profile-home-base = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      shell
      comma
    ];

    home.packages = with pkgs; [
      nh
    ];

    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
