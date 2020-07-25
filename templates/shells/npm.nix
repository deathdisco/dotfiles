{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "typescript-env";

  buildInputs = with pkgs; [
    nodejs
    nodePackages.typescript
    # nodePackages.jq
  ];

  shellHook = "";
}