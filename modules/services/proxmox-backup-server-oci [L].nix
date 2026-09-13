{ inputs, ... }: {
  flake.modules.nixos.proxmox-backup-server-oci = { ... }: {
    imports = with inputs.self.modules.nixos; [
      docker
    ];

    virtualisation.oci-containers = {
      backend = "docker";
      containers.pbs = {
        # https://github.com/dockur/proxmox-backup
        image = "dockurr/proxmox-backup:latest";
        hostname = "pbs";

        environment = {
          TZ = "America/Los_Angeles";
        };

        ports = [
          "8007:8007"
        ];

        volumes = [
          "/persist/pbs/config:/etc/proxmox-backup"
          "/persist/pbs/data:/var/lib/proxmox-backup"
          "/backup/pbs:/backup/pbs"
        ];

        extraOptions = [
          "--tmpfs=/run"
          "--stop-timeout=120"
        ];
      };
    };
  };
}
