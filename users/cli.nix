{ config, pkgs, ... }:

let
      
in { home.packages = with pkgs; [
		htop ytop gotop # performance monitor
		ranger # file manager
		# hunter # rust based file manager
		vifm # vim file manager
		broot # awesome file manager, sorter, finder
		fzf # fuzzy finder and launcher
		youtube-dl # video downloader
		bat # cat with syntax highlighting
		# dust # du replacement (broken?)
		ripgrep # fast rust grepping tool
		megatools # mega.nz cli tools
		autojump # z/j directory jump for zsh
		peco # output/list filtering
		tealdeer # rust tldr client - man page summarising https://github.com/dbrgn/tealdeer
		gitAndTools.tig # c-based curses git client https://github.com/jonas/tig
		ctodo # todo list
		exa # ls replacement
	];
}
