{ config, pkgs, ... }:
let
  extensions = (with pkgs.vscode-extensions; [ bbenoist.Nix ])
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nixfmt-vscode";
        publisher = "brettm12345";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      {
        name = "remote-ssh";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "04niirbkrzsm4wk22pr5dcfymnhqq4vn25xwkf5xvbpw32v1bpp3";
      }
      {
        name = "Bookmarks";
        publisher = "alefragnani";
        version = "11.3.0";
        sha256 = "1rw2xnbdrjsqy5jkkpydpipic49gy00w2266n6sgsv7fin8shb3n";
      }
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
      {
        name = "theme-dracula";
        publisher = "dracula-theme";
        version = "2.22.1";
        sha256 = "13x8vayak9b1biqb4rvisywh1zzh5l7g63kv7y6kqgirm2b5wzsi";
      }
      {
        name = "northernlights";
        publisher = "Eskilop";
        version = "1.0.1";
        sha256 = "1wdxixmdvkabwsq8ydmyyky5yqqvrdwb0c64l22x99viavq6azsb";
      }
    ];
  vscodium-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = extensions;
  };
in { home.packages = [ vscodium-with-extensions ]; }
