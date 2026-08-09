{ inputs, lib, ... }:
{
  flake.modules.nixos.pc = { config, ... }: {
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/774ee796-0071-4089-b217-a0385718c9e7";
      fsType = "btrfs";
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/774ee796-0071-4089-b217-a0385718c9e7";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/774ee796-0071-4089-b217-a0385718c9e7";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/EC33-E64A";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
