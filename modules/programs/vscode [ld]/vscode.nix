{ inputs, lib, ... }:
{
  flake.modules.homeManager.vscode = { pkgs, ... }: {
    home.packages = with pkgs; [ nixd ];

    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          "editor.wordWrap" = "on";
          "editor.minimap.enabled" = true;
          "editor.formatOnSave" = true;
          "editor.inlayHints.enabled" = "off";
          "editor.rulers" = [ 100 ];
          "gitlens.hovers.currentLine.over" = "line";
          "files.autoSave" = "off";
          "workbench.colorTheme" = "One Dark Pro Darker";
          "github.copilot.enable"."*" = true;
          "rust-analyzer.check.overrideCommand" = [
            "cargo"
            "clippy"
            "--workspace"
            "--message-format=json-diagnostic-rendered-ansi"
            "--all-targets"
            "--"
            "--no-deps"
          ];
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings"."nixd"."formatting"."command" = "nixfmt";

          "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        extensions =
          with pkgs.vscode-extensions;
          [
            eamodio.gitlens
            ms-vsliveshare.vsliveshare
            rust-lang.rust-analyzer
            naumovs.color-highlight
            mkhl.direnv
            editorconfig.editorconfig
            usernamehw.errorlens
            dbaeumer.vscode-eslint
            tamasfe.even-better-toml
            golang.go
            esbenp.prettier-vscode
            ms-vscode.hexeditor
            bbenoist.nix
            zhuangtongfa.material-theme
            elixir-lsp.vscode-elixir-ls
            arktypeio.arkdark
            jnoortheen.nix-ide
            ExodiusStudios.comment-anchors
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "zirco-lang";
              publisher = "zirco";
              version = "0.1.2";
              sha256 = "sha256-IigPzn+0JApWbBb8Zv7Zg3AXtVnJDfa0Mf4XbXjeivc=";
            }
          ];
      };
    };
  };
}
