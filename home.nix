{
  config,
  pkgs,
  zpkgs,
  ...
}:

{
  home.username = if pkgs.stdenv.isLinux then "logn" else "logandevine";
  home.homeDirectory = if pkgs.stdenv.isLinux then "/home/logn" else "/Users/logandevine";
  home.packages = with pkgs; [
    delta
    zpkgs.zrc
    zpkgs.libzr
    git-absorb
  ];

  home.shellAliases = {
    # Git
    gip = "git push";
    gipl = "git pull";
    gia = "git add";
    gcm = "git commit";
    gst = "git status";
    gsw = "git switch";
    gco = "git checkout";
    gid = "git diff";

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

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      credential.helper = "libsecret";
      user = {
        name = "Logan Devine";
        email = "nutdriver716@gmail.com";
      };
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        features = "line-numbers decorations";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      alias = {
        co = "checkout";
        sw = "switch";
        tree = "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %c %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      nerdtree
      lightline-vim
      gruvbox
      undotree
    ];
    extraConfig = ''
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set autoindent
      set copyindent
      autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2

      autocmd VimEnter * NERDTree | wincmd p
      autocmd VimEnter * ++nested colorscheme gruvbox
    '';
  };

  programs.powerline-go.enable = true;
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
}
