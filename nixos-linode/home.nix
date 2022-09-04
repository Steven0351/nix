{ pkgs, ... }:
let
  packages = with pkgs; [
    btop
    font-awesome
    fzf
    gcc
    glow
    neofetch
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-github
    nodePackages.prettier
    nodejs # needed for tree-sitter cli
    ripgrep
    stylua
    tree-sitter
    wget
    unzip
  ];
in
{
  home.packages = packages;

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/jq.nix
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/linux/direnv.nix
  ];
}
