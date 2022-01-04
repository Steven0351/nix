{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    fzf
    glow
    neofetch
    (neovim-unwrapped.overrideAttrs (old: rec {
      version = "0.6.1";

      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "v${version}";
        sha256 = "sha256-0XCW047WopPr3pRTy9rF3Ff6MvNRHT4FletzOERD41A=";
      };
    }))
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
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
