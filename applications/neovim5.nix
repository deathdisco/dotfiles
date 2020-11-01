# to check scripts loaded: :scriptnames
# common config:
#  https://github.com/neovim/nvim-lspconfig
#  https://github.com/neovim/nvim-lspconfig
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
        sha256 = "1yinx58jrj8dh58ggv4g3qpdi45swrnr0654ikmps2kjijvnlr90";
      };
    };

    nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-web-devicons";
      src = pkgs.fetchFromGitHub {
        owner = "kyazdani42";
        repo = "nvim-web-devicons";
        rev = "d434e9c8f408688bbf2acdbf72da7e85df19d4e0";
        sha256 = "0c4p0zcc5h45bmc9545m8lnb18whdqh1qb4r2kjhp10id584xjdr";
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
  
in {
  #home.packages = with pkgs; [ vifm nodejs rust-analyzer ctags rustup ];
  home.packages = with pkgs; [ rust-analyzer rnix-lsp fzf ];
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
      plugins = with allPlugins; [ deoplete-lsp deoplete-nvim fzf-vim nvim-lspconfig nerdtree vim-airline vim-autoformat barbar nvim-web-devicons ];
      extraConfig = ''
        set mouse=a
        set nobackup
        set noswapfile
        set hlsearch is " highlight words while searching
        set number " show line numbers

        nnoremap <silent> <C-w> :q<CR>
        nnoremap <silent> <C-W> :q!<CR>
        nnoremap <silent> <C-q> :quitall<CR>
        nnoremap <silent> <C-Q> :quitall!<CR>
        nnoremap <silent> <C-s> :w<CR>
        nnoremap <silent> <C-t> :tabnew<CR>

        " lsp
        lua <<EOF
          vim.cmd('packadd nvim-lspconfig')
          require'nvim_lsp'.rust_analyzer.setup{}
          require'nvim_lsp'.rnix.setup{}
        EOF

        autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

        " Enable deoplete autocompletion in Rust files
        "let g:deoplete#enable_at_startup = 1

        " customise deoplete                                                                                                                                                     " maximum candidate window length
        "call deoplete#custom#source('_', 'max_menu_width', 80)

        " autoformat
        autocmd BufWrite * :Autoformat

        " nerdtree
        nnoremap <silent> <C-b> :NERDTreeToggle<CR>
        let g:NERDTreeWinPos = 'left'
        let g:NERDTreeWinSize = 30
        let g:NERDTreeQuitOnOpen = 0
        let g:NERDTreeHijackNetrw = 0
        let g:NERDTreeMouseMode = 3 " single click tree

        " FZF
        "noremap <silent> <C-p> :call fzf#run({'source': 'exa --git-ignore --recurse --oneline', 'sink': 'e', 'window': '30new'})<CR>
        noremap <silent> <C-p> :call fzf#run({'sink': 'e', 'window': '10new'})<CR>
      '';
    };

    # home.file.".config/nvim/coc-settings.json".text = ''
    # {
    #   "coc.preferences.formatOnSaveFiletypes": ["rust", "nix"],
    #   "rust-analyzer.serverPath": "${pkgs.rust-analyzer}/bin/rust-analyzer",
    #   "rust-analyzer.inlayHints.chainingHints": true,

    #   "rust-client.rustupPath": "${pkgs.rustup}/bin/rustup",
    #   "rust-client.rlsPath": "${pkgs.rustup}/bin/rls",
    #   "rust-client.rustfmt_path": "${pkgs.rustup}/bin/rustfmt",
    #   "rust-client.racer_completion": true
    # }
    # '';

    # home.file.".config/nvim/init.vim".text = ''
    # '';
}
