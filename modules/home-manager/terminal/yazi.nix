{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.yazi;
  inherit (lib) mkIf mkOption types;
in
{
  options.terminal.yazi = {
    enable = mkOption {
      description = "enable yazi";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      
      settings = {
        mgr = {
          show_hidden = true;
        };
      };
    };
  };
}
