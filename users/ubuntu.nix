{ config, pkgs, ... }: {
  nixpkgs.config = { allowUnfree = true; };

  programs = {
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "vim";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        XDG_DATA_DIRS = "$XDG_DATA_DIRS:$HOME/.nix-profile/share/";
      };
      bashrcExtra = ''
        source ~/.nix-profile/etc/profile.d/nix.sh

        alias ls='exa'
        alias z='zrs'
        alias open='xdg-open'

        # prompt
        PS1="\w> "

        neofetch --disable gpu
      '';
    };
  };

  # home.packages = [ pkgs.chromium ];

  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override { useOzone = true; };
  };

  imports = [
    ../packages.nix
    # ./applications/alacritty.nix
    # ./applications/kitty.nix
    # ./applications/tmux.nix
    # ./applications/vim.nix
    # ./applications/rofi.nix
  ];

  fonts.fontconfig.enable = true;
}
