{ inputs, ... }:
{
  flake.modules.nixos.host-redwood = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      profile-workstation
      inputs.nixos-hardware.nixosModules.msi-b550-a-pro
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    time.timeZone = "America/Los_Angeles";

    hardware.enableAllFirmware = true;

    users.users."logn" = {
      isNormalUser = true;
      description = "Logan Devine";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
    home-manager.users.logn = {
      imports = [
        inputs.self.modules.homeManager.profile-workstation
      ];
    };

    system.stateVersion = "26.05";
  };
}
