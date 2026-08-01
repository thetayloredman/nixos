{ inputs, ... }:
{
  flake.modules.homeManager.temphome =
    { pkgs, lib, ... }:
    {
      home.packages =
        with pkgs;
        [
          delta
          git-absorb
          mtr
        ]
        ++ (
          if pkgs.stdenv.isLinux then
            [
              prismlauncher
            ]
          else
            [ ]
        );

      home.shellAliases = {
        # Directory Nav
        ll = "ls -lh";
        la = "ls -lah";
        ".." = "cd ..";
        "..." = "cd ../..";
        "cdt" = "cd $(mktemp -d)";

        # Shell Utilities
        c = "clear";

        # i hate macos
        mtr = if pkgs.stdenv.isLinux then "mtr" else "sudo mtr";
      };
      programs.zsh = {
        enable = true;
        initContent = ''
          mk() {
              if [ -z "$1" ]; then
              echo "Usage: mk <dirname>"
              return 1
              fi

              mkdir -p "$1" && cd "$1"
          }
          export GPG_TTY=$(tty)
        '';
      };
      # nix devshells for some reason default to bash, so also keep bash available:
      programs.bash = {
        enable = true;
        initExtra = ''
          mk() {
              if [ -z "$1" ]; then
              echo "Usage: mk <dirname>"
              return 1
              fi

              mkdir -p "$1" && cd "$1"
          }
        '';
      };

      programs.powerline-go.enable = true;
      programs.powerline-go.settings.hostname-only-if-ssh = true;
      programs.direnv.enable = true;

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "25.05";

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
