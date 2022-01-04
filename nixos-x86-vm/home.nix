{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop 
    fzf
    glow
    neofetch
    neovim
    nerdfonts
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-github
    nodePackages.neovim 
    nodePackages.prettier
    # pinentry-curses
    ripgrep
    stylua 
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    pinentryFlavor = "curses";
  };

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/direnv.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/git.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/jq.nix
    ../shared/home-manager/starship.nix
  ];

  xdg.configFile.nvim = {
    source = ../shared/nvim;
    recursive = true;
  };
}
