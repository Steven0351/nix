{ lib, config, ... }:
let
  cfg = config.terminal.utils;
  mkEnableDefault =
    tool:
    lib.mkOption {
      description = "enable " ++ tool;
      type = lib.types.bool;
      default = true;
    };
in
{
  options.terminal.utils = {
    enable = mkEnableDefault "utils";
    btop = mkEnableDefault "btop";
    ripgrep = mkEnableDefault "ripgrep";
    jq = mkEnableDefault "jq";
    home-manager = mkEnableDefault "home-manager";
    direnv = mkEnableDefault "direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.btop.enable = cfg.btop;
    programs.ripgrep.enable = cfg.ripgrep;
    programs.jq.enable = cfg.jq;
    programs.home-manager.enable = cfg.home-manager;
    programs.direnv = lib.mkIf cfg.direnv {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
