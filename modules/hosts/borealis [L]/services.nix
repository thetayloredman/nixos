{ inputs, ... }: {
  flake.modules.nixos.borealis = {
    imports = with inputs.self.modules.nixos; [
      proxmox-backup-server-oci
      logmuks
      gatus
      synapse-db-wal-archiver
    ];

    custom.services.gatus.config-name = "borealis";
  };
}
