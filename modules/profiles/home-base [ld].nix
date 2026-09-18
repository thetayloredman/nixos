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

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
