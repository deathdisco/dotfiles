# spotify command line client

{ pkgs, home, ... }:
{
  home.packages = with pkgs; [ ncspot ];

  home.file.".config/sway/config".text = ''
    use_nerdfont = true
    
    [keybindings]
    "Shift+i" = "seek +10000"
  '';

}
