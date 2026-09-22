{ inputs, ... }: {
  flake.modules.nixos.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [ fonts ];

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

      services.displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          cursor.size = 32;
          keyboard.layout = "us";
        };
        cursorTheme = {
          name = "phinger-cursors-light";
          package = pkgs.phinger-cursors;
        };
      };
    };

  flake.modules.homeManager.niri = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      inputs.noctalia.homeModules.default
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

    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          external_ip_enabled = true;
          setup_wizard_enabled = false;
        };
        bar = {
          default = {
            start = [
              "launcher"
              "workspaces"
            ];
            center = [ "clock" ];
            end = [
              "media"
              "tray"
              "cpu"
              "cpu-graph"
              "ram"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "control-center"
              "session"
            ];
          };
        };
        widget = {
          cpu = {
            type = "sysmon";
            stat = "cpu_usage";
          };
          cpu-graph = {
            type = "sysmon";
            stat = "cpu_usage";
            visualization = "graph";
            show_value = false;
          };
          ram = {
            type = "sysmon";
            stat = "ram_used";
          };
        };
        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "suspend"
          ];
          pre_action_fade_seconds = 4.0;
          behavior = {
            lock = {
              enabled = true;
              timeout = 600;
              action = "lock";
            };
            screen-off = {
              enabled = true;
              timeout = 660;
              action = "screen_off";
            };
            suspend = {
              enabled = true;
              timeout = 900;
              action = "lock_and_suspend";
            };
          };
        };
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
