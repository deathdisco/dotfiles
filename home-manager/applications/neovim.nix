# to check scripts loaded: :scriptnames
# common config:
#  https://github.com/neovim/nvim-lspconfig
#  https://github.com/neovim/nvim-lspconfig
#
# to check keymappings in vim, verbose imap <tab>
{ config, pkgs, ... }:
let
  neovim-nightly = (pkgs.callPackage ../../packages/nvim-nightly.nix { });
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

    coc-actions = pkgs.vimUtils.buildVimPlugin {
      name = "coc-actions";
      src = pkgs.fetchFromGitHub {
        owner = "iamcco";
        repo = "coc-actions";
        rev = "e7aa3d33b7dfe26a144e87054e742643c583da60";
        sha256 = "0s40xw3yr0fll30a7184q2mijp7xivb1m4phmh70nyrkng7d842j";
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
  # home.packages = with pkgs; [ rust-analyzer rnix-lsp fzf nodejs rustup ];
  programs.neovim = {

    enable = true;
    package = neovim-nightly;
    # finalPackage = neovim-nightly;
    # configure = {
    #   vam.knownPlugins = pkgs.vimPlugins // customPlPugins;
    #   vam.pluginDictionaries = [{ names = [" neoterm" "coc-explorer" "onedark-vim" ]; }];
    # };
    # plugins = with pkgs.vimPlugins; [ coc-explorer ];
    # nvim-treesitter coc-explorer
    plugins = with allPlugins; [
      coc-actions
      neomake
      vim-togglelist
      coc-rust-analyzer
      coc-nvim
      completion-nvim
      fzf-vim
      nerdtree
      vim-airline
      vim-autoformat
      barbar
      nvim-web-devicons
    ];
    extraConfig = ''
      set mouse=a
      set nobackup
      set noswapfile
      set hlsearch is " highlight words while searching
      set number " show line numbers
      set title
      set cmdheight=1
      set mouse=a
      "set cmdwinheight=10

      " make tab the trigger for autocomplete
      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
      " position. Coc only does snippet and additional edit on confirm.
      " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
      if exists('*complete_info')
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
      else
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      endif

      " GoTo code navigation.
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
      noremap <silent> <C-LeftMouse> <Plug>(coc-definition)

      " Use K to show documentation in preview window.
      nnoremap <silent> K :call <SID>show_documentation()<CR>

      noremap <silent> <C-w> :q<CR>
      inoremap <silent> <C-w> <ESC>:q<CR>
      noremap <silent> <C-W> :q!<CR>
      noremap <silent> <C-q> :quitall<CR>
      noremap <silent> <C-Q> :quitall!<CR>
      noremap <silent> <C-s> :w<CR>
      inoremap <silent> <C-s> <ESC>:w<CR>
      noremap <silent> <C-t> :tabnew<CR>

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
      noremap <silent> <C-p> :call fzf#run({'sink': 'e', 'window': '10new'})<CR>
    '';
  };

  home.file.".config/nvim/coc-settings.json".text = ''
    {
      "coc.preferences.formatOnSaveFiletypes": ["rust", "nix"],
      "rust-analyzer.serverPath": "${pkgs.rust-analyzer}/bin/rust-analyzer",

      "rust-client.rustupPath": "${pkgs.rustup}/bin/rustup",
      "rust-client.rlsPath": "${pkgs.rustup}/bin/rls",
      "rust-client.rustfmt_path": "${pkgs.rustup}/bin/rustfmt",
      "rust-client.racer_completion": true
    }
  '';

  # home.file.".config/nvim/init.vim".text = ''
  # '';
}
