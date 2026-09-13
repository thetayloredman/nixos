{ ... }: {
  flake.modules.nixos.redwood = { config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable = true;
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
  };
}
