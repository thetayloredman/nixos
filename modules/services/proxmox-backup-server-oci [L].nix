{ inputs, ... }: {
  flake.modules.nixos.proxmox-backup-server-oci =
    { config, pkgs, ... }:
    # we use our own entrypoint to make it secrets compatible
    let
      pbs-entrypoint = pkgs.writeTextFile {
        name = "pbs-entrypoint";
        executable = true;
        text = ''
          #!/bin/sh
          set -eu

          export PASSWORD_HASH="$(cat /run/secrets/pbs-password-hash)"

          exec /usr/bin/tini -s /usr/local/bin/entrypoint.sh "$$@"
        '';
      };
    in
    {
      imports = with inputs.self.modules.nixos; [
        docker
      ];

      virtualisation.oci-containers = {
        backend = "docker";
        containers.pbs = {
          # https://github.com/dockur/proxmox-backup
          image = "dockurr/proxmox-backup:latest";
          hostname = "pbs";

          entrypoint = "/custom-entrypoint.sh";

          environment = {
            TZ = "America/Los_Angeles";
          };

          ports = [
            "8007:8007"
          ];

          volumes = [
            "${pbs-entrypoint}:/custom-entrypoint.sh:ro"
            "${config.age.secrets.pbs-password-hash.path}:/run/secrets/pbs-password-hash:ro"
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

      networking.firewall.allowedTCPPorts = [ 8007 ];
    };
}
