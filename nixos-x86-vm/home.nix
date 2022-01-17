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
in
{
  home.packages = [
    firaCode
    neovim-0_6_1
  ] ++ with pkgs; [
    btop
    fzf
    glow
    neofetch
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-github
    nodePackages.prettier
    ripgrep
    stylua
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code Nerd Font";
      size = "13.0"
    };

    settings = {
      foreground = "#C8D0E0";
      background = "#2E3440";

      selection_foreground = "#000000";
      selection_background = "#FFFACD";

      url_color = "#0087BD";

      cursor = "#81A1C1";

      # black
      color0 = "#3B4252";
      color8 = "#4C566A";

      # red
      color1 = "#BF616A";
      color9 = "#DE878F";

      # green
      color2 = "#A3BE8C";
      color10 = "#8FBCBB";

      # yellow
      color3 = "#EBCB88B";
      color11 = "#EBCB88B";

      # blue
      color4 = "#81A2C1";
      color12 = "#81A2C1";

      # magenta
      color5 = "#B988B0";
      color13 = "#B48EAD";

      # cyan
      color6 = "#88C0D0";
      color14 = "#BFBCBB";

      # white
      color7 = "#E5E9F0";
      color15 = "#ECEFF4";

      cursor_shape = "block";
      cursor_blink_interval = "0.75";

      enabled_layouts = "*";

      window_border_width = 1;
      window_margin_width = 0;
      window_padding_width = 0;
      
      inactive_text_alpha = "1.0";

      tab_bar_margin_width = 4;
      tab_bar_style = "fade";
      tab_fade = "1 1 1"; 

      background_opacity = "1.0";

      editor = "nvim";
    };
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
    ../shared/home-manager/linux/xmonad
  ];

  xdg.configFile.nvim = {
    source = ../shared/nvim;
    recursive = true;
  };
}
