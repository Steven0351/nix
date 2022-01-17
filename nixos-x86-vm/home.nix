{ pkgs, ... }:
let
  neovim-0_6_1 = pkgs.neovim-unwrapped.overrideAttrs (old: rec {
    version = "0.6.1";

    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v${version}";
      sha256 = "sha256-0XCW047WopPr3pRTy9rF3Ff6MvNRHT4FletzOERD41A=";
    };
  });

  firaCode = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  };
  
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
    ripgrep
    stylua
  ];
in
{
  home.packages = [
    firaCode
    neovim-0_6_1
  ] ++ packages;

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
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/linux/feh.nix
    ../shared/home-manager/linux/gpg-agent.nix
    ../shared/home-manager/linux/kitty.nix
    ../shared/home-manager/linux/qutebrowser.nix
    ../shared/home-manager/linux/xmonad
  ];
}
