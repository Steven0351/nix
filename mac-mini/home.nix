{ pkgs, ... }:
{
  home.packages = with pkgs; [
    babelfish
    nixpkgs-review
    nmap
    youtube-dl
  ];

  terminal.enable = true;
}
