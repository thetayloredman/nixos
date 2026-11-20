{ inputs, ... }: {
  flake.modules.nixos.hesdc-gatus = {
    imports = with inputs.self.modules.nixos; [
      "${inputs.nixpkgs}/nixos/modules/virtualisation/proxmox-lxc.nix"
      profile-server-minimal
    ];

    proxmoxLXC.manageHostName = true;

    networking.hostId = "150afa9f";
    networking.hostName = "gatus";
    time.timeZone = "Etc/UTC";
    boot.isContainer = true;

    # allow gatus to create raw sockets (ICMP)
    boot.kernel.sysctl = {
      "net.ipv4.ping_group_range" = "63216 63216";
    };

    system.stateVersion = "26.05";
  };
}
