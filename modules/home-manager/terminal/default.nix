{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.terminal;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    ./kitty.nix
    ./tmux.nix
    ./fish.nix
    ./eza.nix
    ./bat
    ./git
    ./gpg
    ./gh.nix
    ./fzf.nix
    ./zoxide.nix
    ./utils.nix
    ./yazi.nix
    ./starship.nix
    ./jj.nix
  ];

  options.terminal = {
    enable = mkEnableOption "terminal";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      _1password-cli
      ast-grep
      bash-language-server
      devenv
      glow
      lua-language-server
      nix-prefetch-github
      nodejs
      openssh
      python3
      sad
      shellcheck
      shfmt
      stylua
      tree-sitter
      universal-ctags
      wget
      yq
      yubikey-manager
    ];
  };
}
