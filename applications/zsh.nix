{ config, pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;

      shellAliases = {
        z = "zrs";
      };
    };
    zsh.oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };
  };
}
