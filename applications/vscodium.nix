{ config, pkgs, ... }:
let
  extensions =
    # (with pkgs.vscode-extensions; [ bbenoist.Nix matklad.rust-analyzer ])
    (with pkgs.vscode-extensions; [ bbenoist.Nix ])
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # nix
      {
        name = "nixfmt-vscode";
        publisher = "brettm12345";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      {
        name = "elm-ls-vscode";
        publisher = "Elmtooling";
        version = "1.2.0";
        sha256 = "0sp2nb2awb332hbmccljhwspv78lq2zfh63dkva29sh6ylzw9la5";
      }
      {
        name = "darwin";
        publisher = "chriskseidel";
        version = "1.5.1";
        sha256 = "025vh14pr7pj91q2hvs59kgv0596sfzzclym8qc1qssfjs2f7dcv";
      }
      {
        name = "todo-tree";
        publisher = "Gruntfuggly";
        version = "0.0.177";
        sha256 = "1j3vgyimc4gamp3dnym9wfk445q5hipjq3cimvpqqa22pk4g0224";
      }
      # rust
      {
        name = "debug";
        publisher = "webfreak";
        version = "0.25.0";
        sha256 = "0qm2jgkj17a0ca5z21xbqzfjpi0hzxw4h8y2hm8c4kk2bnw02sh1";
      }
      {
        name = "rust";
        publisher = "rust-lang";
        version = "0.7.8";
        sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
      }
      {
        name = "rust-analyzer";
        publisher = "matklad";
        version = "0.2.273";
        sha256 = "10gm823yh61js0kpbpqfy0r08j8jhgw5wbx4a01m83yz3n0csg15";
      }
      # {
      #   name = "vscode-rust-test-adapter";
      #   publisher = "Swellaby";
      #   version = "0.11.0";
      #   sha256 = "111vhl71zzh4il1kh21l49alwlllzcvmdbsxyvk9bq3r24hxq1r2";
      # }
      {
        name = "search-crates-io";
        publisher = "belfz";
        version = "1.2.1";
        sha256 = "1nqlm76kgzmvpbh1dis010z1yga4yz9ia3hphqph9gpsf4wghq9b";
      }
      {
        name = "crates";
        publisher = "serayuzgur";
        version = "0.5.2";
        sha256 = "1ibpfkncd2xjxlhp1a92mjz2xpbr2660lc4jrk2lcs0gw8i3iizc";
      }
      # {
      #   name = "EditorConfig";
      #   publisher = "EditorConfig";
      #   version = "0.15.1";
      #   sha256 = "18r19dn1an81l2nw1h8iwh9x3sy71d4ab0s5fvng5y7dcg32zajd";
      # }
      # general
      {
        name = "simple-dark";
        publisher = "travis";
        version = "0.2.2";
        sha256 = "1jkahqi623win64m5mbx75ni3b0qd38k1knn56vrmgw95q5gcbj5";
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
      # themes
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
      {
        name = "overnight";
        publisher = "cev";
        version = "1.7.3";
        sha256 = "095bmwh8p9nz2y9br8jpxhkyliyxqfs8lsvv1v6qh6jdsdza0n4p";
      }
      {
        name = "material-icon-theme";
        publisher = "PKief";
        version = "4.2.0";
        sha256 = "1in8lj5gim3jdy33harib9z8qayp5jn8pz6j0zpicbzxx87g2hm1";
      }
      {
        name = "theme-karyfoundation-themes";
        publisher = "karyfoundation";
        version = "20.0.3";
        sha256 = "1yd3ixbnssm1kjv0wn109wp6szjlc27k33b2cz1l3bkndmjzf69b";
      }
    ];
in {
  home.packages = with pkgs; [ cmake pkgconfig ];

  home.file.".config/VSCodium/User/keybindings.json".text = ''
    [
        {
          "key": "ctrl+p",
          "command": "workbench.action.quickOpen"
        }
        {
          "key": "",
          "command": "workbench.action.files.openFile"
        }
        {
          "key": "",
          "command": "workbench.action.files.openLocalFile"
        }
        {
          "key": "ctrl+o",
          "command": "workbench.action.quickOpenRecent"
        }
        {
          "key": "ctrl+r",
          "command": "workbench.action.debug.run"
        },{
          "key": "ctrl+f5",
          "command": "-workbench.action.debug.run"
        },{
          "key": "ctrl+shiftquick open recent+r",
          "command": "workbench.action.debug.start",
          "when": "!inDebugMode"
        },{
          "key": "f5",
          "command": "-workbench.action.debug.start",
          "when": "!inDebugMode"
        },{
          "key": "ctrl+u",
          "command": "editor.action.deleteLines"
        },{
          "key": "ctrl+p",
          "command": "cursorUp",
        },{
          "key": "ctrl+n",
          "command": "cursorDown",
        }, {
          "key": "ctrl+e",
          "command": "cursorLineEnd",
        }, {
          "key": "ctrl+a",
          "command": "cursorLineStart",
        }, {
          "key": "ctrl+shift+a",
          "command": "cursorLineStartSelect",
        }
      ]'';

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = extensions;
    userSettings = {
      "debug.allowBreakpointsEverywhere" = true;
      "debug.showBreakpointsInOverviewRuler" = true;
      "debug.showInlineBreakpointCandidates" = true;
      "debug.toolBarLocation" = "docked";

      # "lldb.adapterEnv" = {
      #   "PATH" = "${pkgs.cargo}/bin/cargo";
      # };
      "lldb.libpython" = "${pkgs.python3}/lib/libpython3.so";
      "lldb.showDisassembly" = "never";
      # "lldb.executable" = "${pkgs.lldb_10}/bin/lldb";
      # "lldb.library": "${pkgs.lldb_10}/lib/";
      "lldb.verboseLogging" = true;

      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      "[rust]" = { "editor.tabSize" = 4; };

      "editor.formatOnSave" = true;

      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = false; # don't show popups

      "files.insertFinalNewline" = true;
      "files.exclude" = {
        ".yarn" = true;
        "**/*.pyc" = true;
      };

      "git.enableSmartCommit" = true;
      "git.terminalAuthentication" = true;
      "github.gitAuthentication" = false; # otherwise errors occur

      "rust-client.autoStartRls" = false;
      "rust.rustfmt_path" = "/home/nom/.nix-profile/bin/rustfmt";

      "search.exclude" = {
        "**/build" = true;
        "**/target" = true;
      };

      "update.mode" = "none";
      "window.zoomLevel" = 0;

      "window.menuBarVisibility" = "toggle";

      "workbench.colorTheme" = "Simple Dark";
      "workbench.iconTheme" = null;
      "workbench.editor.showIcons" = false;
      # "workbench.fontAliasing" = "antialiased";
    };
  };
}
