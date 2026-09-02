{ inputs, ... }: {
  flake.modules.homeManager.git = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      delta
      git-absorb
    ];

    programs.git = {
      enable = true;
      lfs.enable = true;
      package = pkgs.gitFull;
      settings = {
        credential.helper = "libsecret";
        user = {
          name = "Logan Devine";
          email = "logan@zirco.dev";
          signingkey = "1CBB1085E94E159FC2D7ED6B6C154E1DBCF538F4";
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
        commit.gpgsign = true;
      };
    };

    home.shellAliases = {
      gip = "git push";
      gipf = "git push --force";
      gipl = "git pull";
      gia = "git add";
      gcm = "git commit";
      gst = "git status";
      gsw = "git switch";
      gco = "git checkout";
      gid = "git diff";
      grb = "git rebase";
      gs = "git stash";
      grs = "git restore";
      grss = "git restore --staged";
    };
  };
}
