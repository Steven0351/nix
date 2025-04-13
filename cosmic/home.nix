{ oxilica-nil, neovim-nightly, nixd, ... }: { pkgs, config, ... }:
let
  aspell = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
    d.en-science
  ]);

  lazyvim = pkgs.callPackage ../shared/lazyvim {};

  packages = with pkgs; [
    _1password
    btop
    fzf
    gcc
    glow
    httpie
    languagetool
    lua-language-server
    neofetch
    nix-prefetch-github
    nodejs
    openssh
    pinentry-curses
    pinentry_mac
    python3
    qmk
    ripgrep
    stylua
    sqlite
    sqlite.dev
    sqlite.out
    tree-sitter
    wget
    wordnet
    xcodes
    yubikey-manager
    zellij
  ];
in
{
  home.packages = [
    aspell
    lazyvim
    oxilica-nil.packages.aarch64-darwin.nil
    nixd.packages.aarch64-darwin.nixd
    neovim-nightly.packages.aarch64-darwin.default
  ] ++ packages;
  home.stateVersion = "22.05";

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Steven Sherry";
    userEmail = "steven.r.sherry@gmail.com";

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
      ".envrc"
      ".direnv"
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
    ../shared/home-manager/lazyvim
    ../shared/home-manager/lvim
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/wallpapers.nix
    ../shared/home-manager/zellij.nix
    ../shared/home-manager/macos/direnv.nix
    ../shared/home-manager/macos/gpg-agent.nix
  ];
}
