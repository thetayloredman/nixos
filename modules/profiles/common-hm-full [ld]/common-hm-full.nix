{ inputs, ... }:
{
  flake.modules.homeManager.profile-common-hm-full = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      profile-devel
      mfc
      shell
    ];

    home.packages = with pkgs; [
      nh
    ];

    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
