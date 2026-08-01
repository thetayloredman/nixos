{ inputs, ... }: {
  flake.modules.homeManager.shell = { pkgs, lib, ... }: {

    home.shellAliases = {
      # Directory Nav
      ll = "ls -lh";
      la = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
      "cdt" = "cd $(mktemp -d)";

      # Shell Utilities
      c = "clear";
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
  };
}
