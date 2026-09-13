{ inputs, ... }:
{
  flake.modules.nixos.redwood = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      profile-workstation
      inputs.nixos-hardware.nixosModules.msi-b550-a-pro
    ];

    networking.hostName = "redwood";
    time.timeZone = "America/Los_Angeles";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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
