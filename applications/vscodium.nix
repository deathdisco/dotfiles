{ config, pkgs, ... }:
let
  extensions =
    (with pkgs.vscode-extensions; [
      bbenoist.Nix
      matklad.rust-analyzer
      # llvm-org.lldb-vscode
    ])
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # nix
      {
        name = "nixfmt-vscode";
        publisher = "brettm12345";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      # rust
      # {
      #   name = "debug";
      #   publisher = "webfreak";
      #   version = "0.25.0";
      #   sha256 = "0qm2jgkj17a0ca5z21xbqzfjpi0hzxw4h8y2hm8c4kk2bnw02sh1";
      # }
      # {
      #   name = "vscode-lldb";
      #   publisher = "vadimcn";
      #   version = "1.5.3";
      #   sha256 = "128zh6m7vazg8pn7457a40pzv0n8lms2zm7h9w34k46szwhy5lq6";
      # }
      {
        name = "rust";
        publisher = "rust-lang";
        version = "0.7.8";
        sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
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
      # {
      #   name = "EditorConfig";
      #   publisher = "EditorConfig";
      #   version = "0.15.1";
      #   sha256 = "18r19dn1an81l2nw1h8iwh9x3sy71d4ab0s5fvng5y7dcg32zajd";
      # }
      # general
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
    ];
in {
  home.packages = [
      pkgs.rustfmt
      pkgs.cargo
      pkgs.llvm
      pkgs.rustc
      pkgs.lldb_10
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = extensions;
    userSettings = {
      "debug.allowBreakpointsEverywhere" = true;
      "debug.showBreakpointsInOverviewRuler" = true;
      "debug.showInlineBreakpointCandidates" = true;
      "debug.toolBarLocation" = "docked";

      "lldb.adapterEnv" = {
        "PATH" = "${pkgs.cargo}/bin/cargo";
      };
      "lldb.libpython" = "${pkgs.python3}/lib/libpython3.8.so";
      "lldb.showDisassembly" = "never";

      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      "[rust]" = {
          "editor.tabSize" = 4;
      };

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

      "lldb.verboseLogging" = true;

      "rust-client.autoStartRls" = false;
      "rust.rustfmt_path" = "/home/nom/.nix-profile/bin/rustfmt";

      "search.exclude" = {
          "**/build" = true;
          "**/target" = true;
      };
      
      "update.mode" = "none";
      "window.zoomLevel" = 0;

      "workbench.colorTheme" = "NorthernLights";
      # "workbench.iconTheme" = "material-icon-theme";
      "workbench.editor.showIcons" = false;
      # "workbench.fontAliasing" = "antialiased";
    };
  };
}
