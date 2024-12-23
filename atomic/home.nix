{ oxilica-nil, ... }: { pkgs, config, ... }:
let
  nerdFonts = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" "VictorMono" "SourceCodePro" "JetBrainsMono" ];
  };

  aspell = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
    d.en-science
  ]);

  lvim = pkgs.callPackage ../shared/lvim {
      dataHome = config.xdg.dataHome;
      configHome = config.xdg.configHome;
      cacheHome = config.xdg.cacheHome;
  };

  lazyvim = pkgs.callPackage ../shared/lazyvim {};

  packages = with pkgs; [
    _1password
    btop
    fzf
    gcc
    glow
    httpie
    languagetool
    mitmproxy
    neofetch
    neovim
    nix-prefetch-github
    nodejs
    openssh
    pinentry-curses
    python3
    ripgrep
    stylua
    sqlite
    sqlite.dev
    sqlite.out
    sumneko-lua-language-server
    tree-sitter
    wget
    wordnet
    xcodes
    yubikey-manager
    zathura
    zellij
    zk
  ];
in
{
  home.packages = [ nerdFonts aspell lvim lazyvim oxilica-nil.packages.aarch64-darwin.nil ] ++ packages;
  home.stateVersion = "22.05";

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

    ignores = [
      ".DS_Store"
      "*.log"
      ".idea"
      "tmp/"
    ];

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
    ../shared/home-manager/lvim
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/wallpapers.nix
    ../shared/home-manager/zellij.nix
    ../shared/home-manager/macos/direnv.nix
    ../shared/home-manager/macos/gpg-agent.nix
    ./kitty.nix
  ];
}
