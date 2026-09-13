{ inputs, ... }: {
  flake.modules.nixos.borealis = { pkgs, ... }: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/root"
        "/etc/nixos"
        "/etc/ssh"
        "/var/lib"
        "/var/log"
      ];
    };

    boot.initrd.systemd.services.rollback = {
      description = "Rollback ZFS root file system to blank snapshot";
      wantedBy = [ "initrd-root-device.target" ];
      after = [ "zfs-import-ssd.service" ];
      before = [ "sysroot.mount" ];
      path = [ pkgs.zfs ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.zfs}/bin/zfs rollback -r ssd/local/root@blank";
      };
    };

    age.identityPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
      "/persist/etc/ssh/ssh_host_rsa_key"
    ];
  };
}
