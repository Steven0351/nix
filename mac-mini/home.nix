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

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/git.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/gpg-agent.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/starship.nix
  ];

  xdg.configFile.nvim = {
    source = ../shared/nvim;
    recursive = true;
  };
}
