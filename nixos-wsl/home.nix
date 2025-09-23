{ stevenvim, jj, ... }:
{ pkgs, ... }:
let
  packages = with pkgs; [
    _1password-cli
    ast-grep
    bash-language-server
    gcc
    languagetool
    nodejs
    shellcheck
    shfmt

    socat

    tmux
    sesh

    yq
    jq
  ];
in
{

  home.packages = packages ++ [
    stevenvim.packages."x86_64-linux".stevenvim
    jj.packages.x86_64-linux.jujutsu
  ];
  home.stateVersion = "25.05";
  home.sessionVariables.WIN_HOME = "/mnt/c/Users/Steven.Sherry";
  home.sessionVariables.EDITOR = "stevenvim";

  programs = {
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
    (import ../shared/home-manager/git.nix {
      overrides = {
        userEmail = "steven.sherry@abbyy.com";
      };
    })
    ../shared/home-manager/bat
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/gpg-wsl.nix
    ../shared/home-manager/linux/gpg-agent.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/linux/direnv.nix
  ];
}
