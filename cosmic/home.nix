{ oxilica-nil, nixd, ... }: { pkgs, ... }:
let
  aspell = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
    d.en-science
  ]);

  lazyvim = pkgs.callPackage ../shared/lazyvim {};

  packages = with pkgs; [
    _1password-cli
    aerospace
    bash-language-server
    btop
    fastfetch
    fd
    fzf
    gcc
    glow
    httpie
    languagetool
    lazygit
    lua-language-server
    neovim
    nix-prefetch-github
    nodejs
    openssh
    pinentry-curses
    pinentry_mac
    python3
    qmk
    ripgrep
    rubyPackages.xcodeproj
    sad
    sesh
    shellcheck
    shfmt
    stylua
    sqlite
    sqlite.dev
    sqlite.out
    # TODO use home-manager for this after settling on the options
    tmux
    tree-sitter
    vectorcode
    # This is codelldb
    vscode-extensions.vadimcn.vscode-lldb.adapter
    wget
    wordnet
    xcodes
    xcbeautify
    yq
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

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  imports = [
    ./kitty.nix
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
