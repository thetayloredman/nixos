{ inputs, ... }: {
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker.enable = true;
    users.users.logn.extraGroups = [ "docker" ];
    environment.systemPackages = with pkgs; [
      distrobox
      docker-compose
    ];
  };
}
