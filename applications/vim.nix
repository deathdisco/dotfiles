{ config, pkgs, ... }: {
  programs = {
    vim = {
      enable = true;
      # plugins = [ "vim-airline" "goyo" ];
      settings = { ignorecase = true; };
      extraConfig = ''
        set mouse=a
        set nobackup
        set noswapfile

        let g:NERDTreeMouseMode=2
        let g:NERDTreeHijackNetrw=0

        map <C-b> :NERDTreeToggle<CR>
        map <C-w> :close<CR>
        map <C-t> :tabnew<CR>
        map <C-j> :tabprev<CR>
        map <C-k> :tabnext<CR>
        map <C-s> :write<CR>
        map <C-q> :quit<CR>
        map <C-i> :VimwikiIndex<CR>

        nnoremap 1 1gt
        nnoremap 2 2gt
        nnoremap 3 3gt
        nnoremap 4 4gt
        nnoremap 5 5gt
        nnoremap 6 6gt
        nnoremap 7 7gt
        nnoremap 8 8gt
        nnoremap 9 9gt

        let g:vimwiki_list = [{'path': '~/Notes', 'path_html': '~/.config/wiki', 'ext': 'md', 'syntax': 'markdown'}]
      '';

      # to see available plugins:
      # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      plugins = with pkgs.vimPlugins; [
        # writing
        goyo # distraction-free writing; toggle with :Goyo
        vim-pencil # better word-wrapping, markdown, etc.
        limelight-vim # highlight only current paragraph
        vimwiki

        # search
        ctrlp

        # sidebar
        nerdtree

        # languages
        vim-nix
        swift-vim

        # syntax checking / status
        syntastic

        # typescript
        coc-tslint
        yats-vim

        vim-devicons
      ];
    };
  };
}
