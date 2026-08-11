{ inputs, ... }: {
  flake.modules.nixos.docker = { ... }: {
    virtualisation.docker.enable = true;
    users.users.logn.extraGroups = [ "docker" ];
  };
}
