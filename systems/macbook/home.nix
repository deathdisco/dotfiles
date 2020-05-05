# macos home-manager configuration
#
#   home-manager switch --file ./home.nix
#
{ config, pkgs, ... }:
let
in {
    imports = [
        ../../applications/alacritty.nix
    ];

    programs.bash.sessionVariables.EDITOR = "vim";

    nixpkgs.config = {
        allowUnfree = true;

        environment.variables = {
        EDITOR = "vim";
        PATH = "~/.cargo/bin:$PATH";
        };
    };

    home = {
        packages = [
            # CLI
            pkgs.ranger

            # GUI
        ];
    };
}
