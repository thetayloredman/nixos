{ inputs, ... }: {
  flake.modules.nixos.borealis = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      profile-server
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-pc-ssd
    ];

    networking.hostId = "8425e349";
    networking.hostName = "borealis";
    time.timeZone = "America/Los_Angeles";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = [ "zfs" ];

    services.logind.lidSwitch = "ignore";

    system.stateVersion = "26.05";
  };
}
