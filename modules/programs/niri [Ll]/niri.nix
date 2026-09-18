{ inputs, ... }: {
  flake.modules.nixos.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.niri.enable = true;
      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;

      environment.systemPackages = with pkgs; [
        fuzzel
        mako
        swaylock
        xwayland-satellite
        playerctl
        gnome-calculator
        pavucontrol
      ];
      fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${lib.getExe pkgs.tuigreet} --time --asterisks --user-menu --cmd ${config.programs.niri.package}/bin/niri-session";
          user = "greeter";
        };
      };
      security.pam.services.greetd.enableGnomeKeyring = true;
      # prevent greetd from conflicting with logs at boot time
      systemd.services.greetd = {
        serviceConfig.Type = "idle";
      };
    };

  flake.modules.homeManager.niri = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      ghostty
    ];

    xdg.configFile."niri/config.kdl".source =
      pkgs.runCommand "niri-config-checked"
        {
          nativeBuildInputs = [ pkgs.niri ];
        }
        ''
          niri validate --config ${./config.kdl}
          cp ${./config.kdl} $out
        '';

    programs.waybar = {
      enable = true;
      settings.main = {
        modules-left = [
          "niri/window"
          "idle_inhibitor"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "mpris"
          "pulseaudio"
          "cpu"
          "memory"
          "tray"
        ];
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        cpu.format = "{usage}% ";
        memory.format = "{}% ";
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰅶 {icon} {format_source}";
          format-muted = "󰅶 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "󰂑";
            headset = "󰂑";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };

    services.swayidle =
      let
        lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
        display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
        lock_seconds = 120;
        display_off_seconds = 180;
        suspend_seconds = 200;
      in
      {
        enable = true;
        timeouts = [
          {
            timeout = lock_seconds - 30;
            command = "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds' -t 25000";
          }
          {
            timeout = lock_seconds;
            command = lock;
          }
          {
            timeout = display_off_seconds;
            command = display "off";
            resumeCommand = display "on";
          }
          {
            timeout = suspend_seconds;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = {
          before-sleep = (display "off") + "; " + lock;
          after-resume = display "on";
          lock = (display "off") + "; " + lock;
          unlock = display "on";
        };
      };

    home.pointerCursor = {
      enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };
  };
}
