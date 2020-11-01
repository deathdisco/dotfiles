# to check scripts loaded: :scriptnames
{ config, pkgs, ... }:
let
  neovim-nightly = (pkgs.callPackage ../packages/nvim-nightly.nix { });
  customPlugins = {
    neoterm = pkgs.vimUtils.buildVimPlugin {
      name = "neoterm";
      src = pkgs.fetchFromGitHub {
        owner = "kassio";
        repo = "neoterm";
        rev = "287eb27d0a21d81c92c1183a5527e1ff0fdc95cb";
        sha256 = "06ny9khdyckszxr77w13hsw2jlf92caifr8x382cda2v2vq3jz4n";
      };
    };

    barbar = pkgs.vimUtils.buildVimPlugin {
      name = "barbar";
      src = pkgs.fetchFromGitHub {
        owner = "romgrk";
        repo = "barbar.nvim";
        rev = "798d5ceb3e7b0659aa6d51374d32dc10ca1c0226";
        sha256 = "16ny9khdyckszxr77w13hsw2jlf92caifr8x382cda2v2vq3jz4n";
      };
    };

    onedark-vim = pkgs.vimUtils.buildVimPlugin {
      name = "onedark-vim";
      src = pkgs.fetchFromGitHub {
        owner = "joshdick";
        repo = "onedark.vim";
        rev = "7f36f83f13d3bdbd3dca4e3e8b2a10a5ecdca5e9";
        sha256 = "0cnn3j3invasqh5sn20gf9lvcksqhracrbyr3pn3fs9shp7f1kxw";
      };
    };

    vim-sidebar-manager = pkgs.vimUtils.buildVimPlugin {
      name = "vim-sidebar-manager";
      src = pkgs.fetchFromGitHub {
        owner = "brglng";
        repo = "vim-sidebar-manager";
        rev = "dea072dc28cd3e1ff85ff5d0887a674578aa68f6";
        sha256 = "17adn09f1mmahr70xssdf5plhr28hn2vjxrsagnrmjwknq279dd1";
      };
    };
  };
  allPlugins = pkgs.vimPlugins // customPlugins;

  packageOverrides = pkgs: with pkgs; {
    custom-neovim = neovim.override {
      configure = {
        # package = neovim-nightly;
      # add here code from the example section
      };
    };
  };
  
in {
  #home.packages = with pkgs; [ vifm nodejs rust-analyzer ctags rustup ];
  # home.packages = [ packageOverrides.custom-neovim ];
  programs.neovim = {
    
      enable = true;
      package = neovim-nightly;
      # finalPackage = neovim-nightly;
      # configure = {
      #   vam.knownPlugins = pkgs.vimPlugins // customPlugins;
      #   vam.pluginDictionaries = [{ names = [" neoterm" "coc-explorer" "onedark-vim" ]; }];
      # };
      # plugins = with pkgs.vimPlugins; [ coc-explorer ];
      # nvim-treesitter coc-explorer
      plugins = with allPlugins; [ coc-rls vim-nix neoterm fzf-vim vim-racer vim-startify nerdtree deoplete-rust tagbar vim-airline supertab onedark-vim coc-nvim rust-vim coc-rust-analyzer vim-sidebar-manager ];
      extraConfig = ''
        set mouse=a
        set nobackup
        set noswapfile

        nnoremap <silent> <C-w> :q<CR>
        nnoremap <silent> <C-W> :q!<CR>
        nnoremap <silent> <C-q> :quitall<CR>
        nnoremap <silent> <C-s> :w<CR>
        nnoremap <silent> <C-t> :tabnew<CR>

        " make terminal auto insert mode
        au BufEnter * if &buftype == 'terminal' | :startinsert | endif

        " supertab should complete from top-down
        let g:SuperTabDefaultCompletionType = "<c-n>"
        let g:SuperTabContextDefaultCompletionType = "<c-n>"

        " show buffer number in airline
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1

        let g:racer_cmd = "${allPlugins.vim-racer}/bin/racer"
        let g:racer_experimental_completer = 1

        let g:deoplete#sources#rust#racer_binary = "${allPlugins.vim-racer}/bin/racer"

        " show tags in tagbar
        nnoremap <silent> <C-y> :TagbarToggle<CR>

        " nerdtree
        nnoremap <silent> <C-b> :NERDTreeToggle<CR>
        let g:NERDTreeWinPos = 'left'
        let g:NERDTreeWinSize = 30
        let g:NERDTreeQuitOnOpen = 0
        let g:NERDTreeHijackNetrw = 0
        let g:NERDTreeMouseMode = 3 " single click tree

        " noremap <silent> <C-p> :FZF<CR>
        noremap <C-P> :call fzf#run({'source': 'git ls-files', 'sink': 'e', 'window': '30new'})<CR>
        noremap <C-p> :call fzf#run({'source': 'exa --git-ignore --recurse --oneline', 'sink': 'e', 'window': '30new'})<CR>

        autocmd VimEnter *
          \ if !argc()
          \ | Startify
          \ | NERDTree
          \ | wincmd w
          \ | endif

        " vim-sidebar-manager
        let g:sidebars = {
          \ 'netrw': {
          \     'position': 'left',
          \     'check_win': {nr -> getwinvar(nr, '&filetype') ==# 'netrw'},
          \     'open': 'Lexplore',
          \     'close': 'Lexplore'
          \ }
          \ }
        " noremap <silent> <C-e> :call sidebar#toggle('netrw')<CR>
        let g:startify_session_before_save = ['call sidebar#close_all()']
      '';
    };

    home.file.".config/nvim/coc-settings.json".text = ''
    {
      "coc.preferences.formatOnSaveFiletypes": ["rust", "nix"],
      "rust-analyzer.serverPath": "${pkgs.rust-analyzer}/bin/rust-analyzer",
      "rust-analyzer.inlayHints.chainingHints": true,

      "rust-client.rustupPath": "${pkgs.rustup}/bin/rustup",
      "rust-client.rlsPath": "${pkgs.rustup}/bin/rls",
      "rust-client.rustfmt_path": "${pkgs.rustup}/bin/rustfmt",
      "rust-client.racer_completion": true
    }
    '';

    # home.file.".config/nvim/init.vim".text = ''
    # '';
}
