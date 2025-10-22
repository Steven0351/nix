{ lib, config, ... }:
let
  cfg = config.terminal.zoxide;
  inherit (lib) mkOption types mkIf;
in
{
  options.terminal.zoxide = {
    enable = mkOption {
      description = "enable zoxide";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.terminal.fish.enable;
    };
  };
}
