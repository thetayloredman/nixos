{ lib, ... }: {
  flake.modules.nixos.borealis = { config, ... }: {
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "sr_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "ssd/local/root";
      fsType = "zfs";
      neededForBoot = true;
    };

    fileSystems."/nix" = {
      device = "ssd/local/nix";
      fsType = "zfs";
      neededForBoot = true;
    };

    fileSystems."/persist" = {
      device = "ssd/safe/persist";
      fsType = "zfs";
      neededForBoot = true;
    };

    fileSystems."/home" = {
      device = "ssd/safe/home";
      fsType = "zfs";
    };

    fileSystems."/hdd" = {
      device = "hdd";
      fsType = "zfs";
    };

    fileSystems."/backup/pbs" = {
      device = "backup/pbs";
      fsType = "zfs";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A40A-C98F";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/5d5df086-ec8b-4a09-bca8-967b8d5ce409"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
