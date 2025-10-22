{ lib, config, ... }:
let
  cfg = config.terminal.bat;
in
{
  options.terminal.bat = {
    enable = lib.mkOption {
      description = "enable bat";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      config = {
        theme = "kanagawa";
      };
      themes = {
        kanagawa = {
          src = ./themes;
          file = "kanagawa.tmTheme";
        };
      };
      enable = true;
    };
  };
}
