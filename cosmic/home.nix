{ nixd, jj, ... }:
{ pkgs, ... }:
let
  aspell = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
    d.en-science
  ]);

  lazyvim = pkgs.callPackage ../shared/lazyvim { };

  packages = with pkgs; [
    _1password-cli
    ast-grep
    bash-language-server
    devenv
    gcc
    glow
    httpie
    languagetool
    lua-language-server
    neovim
    nix-prefetch-github
    nodejs
    openssh
    pinentry-curses
    pinentry_mac
    python3
    qmk
    rubyPackages.xcodeproj
    sad
    shellcheck
    shfmt
    stylua
    sqlite
    sqlite.dev
    sqlite.out

    # TODO use home-manager for this after settling on the options
    tmux
    sesh

    yabai

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
  ];
in
{
  home.packages = [
    aspell
    lazyvim
    jj.packages.aarch64-darwin.jujutsu
    nixd.packages.aarch64-darwin.nixd
  ]
  ++ packages;
  home.stateVersion = "22.05";

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Steven Sherry";
      userEmail = "steven.r.sherry@gmail.com";

      delta = {
        enable = true;
        options = {
          features = "kanagawa-wave";
          syntax-theme = "kanagawa";
          line-numbers = true;
        };
      };

      includes = [
        { path = "~/.config/git/kanagawa.gitconfig"; }
      ];

      ignores = [
        ".DS_Store"
        "*.log"
        ".idea"
        "tmp/"
        ".envrc"
        ".direnv"
        ".nvim.lua"
      ];

      signing = {
        key = "5BE85414B74F99B1";
        signByDefault = true;
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    yazi.enable = true;
    btop.enable = true;
    lazygit.enable = true;
    fastfetch.enable = true;
    ripgrep.enable = true;
    zathura.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    fd.enable = true;
  };

  catppuccin = {
    flavor = "mocha";
    enable = false;
  };

  home.file.".config/sketchybar".source = ./config/sketchybar;
  home.file.".config/yabai/yabairc".source = ./config/yabai/yabairc;

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
