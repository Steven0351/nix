{ pkgs, ... }:
let
  packages = with pkgs; [
    ast-grep
    bash-language-server
    gcc
    languagetool
    nodejs
    shellcheck
    shfmt

    tmux
    sesh

    jujutsu

    yq
    jq
  ];
in
{

  home.packages = packages;
  home.stateVersion = "25.05";

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Steven Sherry";
      userEmail = "steven.sherry@abbyy.com";

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

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    yazi.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    ripgrep.enable = true;
    jq.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    fd.enable = true;
  };

  imports = [
    ./kitty.nix
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/linux/gpg-agent.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/linux/direnv.nix
  ];
}
