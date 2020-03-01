{ config, pkgs, ... }:

let
      
in { home.packages = with pkgs; [
	nmap # port scanner
];}