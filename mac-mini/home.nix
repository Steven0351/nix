{ pkgs, ...}: {
  home.packages = with pkgs; [
    babelfish
    btop
    fzf
    neofetch
    neovim
    nerdfonts
    nixpkgs-review
    nmap
    nodePackages.neovim
    nodePackages.prettier
    nodejs
    pinentry-curses
    ripgrep
    stylua
    wget
    youtube-dl
  ];

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/git.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/macos/gpg-agent.nix
  ];
}
