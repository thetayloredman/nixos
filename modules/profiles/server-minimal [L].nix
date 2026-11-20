{ inputs, ... }: {
  flake.modules.nixos.profile-server-minimal = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      nix
      secrets
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    environment.systemPackages = with pkgs; [
      vim
    ];

    services.openssh.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
