{ inputs, ... }: {
  flake.modules.homeManager.neovim = { pkgs, ... }: {
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      withPython3 = false;
      withRuby = false;
      plugins = {
        fugitive.enable = true;
        lightline.enable = true;
        undotree.enable = true;
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
          };
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [ nerdtree ];
      opts = {
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        autoindent = true;
        copyindent = true;
        textwidth = 120;
        colorcolumn = "+1";
        foldlevel = 99;
      };
      files = {
        "ftplugin/gitcommit.lua".opts = {
          textwidth = 72;
        };
        "ftplugin/nix.lua".opts = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      };
      autoCmd = [
        {
          event = [ "VimEnter" ];
          pattern = [ "*" ];
          command = "NERDTree | wincmd p";
        }
      ];
    };
  };
}
