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
    (import ../shared/home-manager/git.nix { })
    ../shared/home-manager/bat
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
