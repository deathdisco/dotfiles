let vscode-insider = prev.vscode.override { isInsiders = true; };
in {
  vscode = vscode-insider.overrideAttrs (oldAttrs: rec {
    src = (builtins.fetchTarball {
      url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
      sha256 = "03nmmcr8canxnhxpsd2d5rfqi6d7njab4c3bpcqmfi9xbk3scx1a";
    });
    version = "latest";
  });
}
