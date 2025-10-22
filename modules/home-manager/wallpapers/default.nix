{ lib, config, ... }:
let
  cfg = config.wallpapers;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.wallpapers = {
    enable = mkEnableOption "enable wallpapers";
  };

  config = mkIf cfg.enable {
    xdg.dataFile.wallpapers = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
