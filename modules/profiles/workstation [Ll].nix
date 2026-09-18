{ inputs, ... }:
{
  flake.modules.nixos.profile-workstation = { config, ... }: {
    imports = with inputs.self.modules.nixos; [
      profile-gaming
      profile-devel
      profile-multimedia
      home-manager
      nix
      zram
      secrets
      shell
      niri
    ];

    security.rtkit.enable = true;
    networking.firewall.enable = true;

    programs.firefox.enable = true;
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.openssh.enable = true;
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    networking.networkmanager.enable = true;
  };

  flake.modules.homeManager.profile-workstation = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      home-linux
      profile-gaming
      profile-multimedia
      profile-devel
      mfc
      niri
    ];

    home.packages = with pkgs; [
      discord
      kdePackages.kate
    ];
  };
}
