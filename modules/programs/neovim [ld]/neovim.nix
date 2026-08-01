{ inputs, ... }: {
  flake.modules.homeManager.neovim = { pkgs, lib, ... }: {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      withPython3 = false;
      withRuby = false;
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
        set textwidth=120
        set colorcolumn=+1
        autocmd FileType gitcommit setlocal textwidth=72
        autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2

        autocmd VimEnter * NERDTree | wincmd p
        autocmd VimEnter * ++nested colorscheme gruvbox
      '';
    };
  };
}
