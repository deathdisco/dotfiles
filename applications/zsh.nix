{ config, pkgs, ... }: {
  # Enable zsh
  programs.zsh.enable = true;

  # Enable Oh-my-zsh
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" ];
  };
}
