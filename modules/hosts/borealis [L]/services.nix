{ inputs, ... }: {
  flake.modules.nixos.borealis = {
    imports = with inputs.self.modules.nixos; [
      proxmox-backup-server-oci
      logmuks
    ];
  };
}
