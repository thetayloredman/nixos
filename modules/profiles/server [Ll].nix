{ inputs, ... }: {
  flake.modules.nixos.profile-server = {
    imports = with inputs.self.modules.nixos; [
      home-manager
      nix
      zram
      secrets
      shell
      theming
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    services.openssh.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.networkmanager.enable = true;
  };

  flake.modules.homeManager.profile-server = {
    imports = with inputs.self.modules.homeManager; [
      home-linux
    ];
  };
}
