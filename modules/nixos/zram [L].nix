{ inputs, ... }: {
  flake.modules.nixos.zram = {
    systemd.oomd.enable = true;
    zramSwap.enable = true;
  };
}
