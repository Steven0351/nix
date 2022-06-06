{ pkgs, ...}:
let 
  firaCode = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  }; 
  
  packages = with pkgs; [
    btop
    fzf
    gcc
    glow
    neofetch
    neovim
    nix-prefetch-github
    nodejs
    openssh
    pinentry-curses
    ripgrep
    stylua
    tree-sitter
    wget
    yubikey-manager
    zathura
    zellij
    zk
  ];
in 
{
  home.packages = [ firaCode ] ++ packages; 

  programs.git = {
    enable = true;
    userName = "Steven Sherry";
    userEmail = "steven.sherry@ionic.io";

    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
        line-numbers = true;
      };
    };

    ignores = [ ".DS_Store" ];

    signing = {
      key = "5BE85414B74F99B1";
      signByDefault = true;
    };
  };

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/jq.nix
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/wallpapers.nix
    ../shared/home-manager/zellij.nix
    ../shared/home-manager/macos/direnv.nix
    ../shared/home-manager/macos/gpg-agent.nix
    ../shared/home-manager/macos/kitty
  ];
}
