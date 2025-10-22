{ lib, config, ... }:
let
  cfg = config.terminal.eza;
  inherit (lib) mkOption mkIf types;
in
{
  options.terminal.eza = {
    enable = mkOption {
      description = "enable eza";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.eza.enable = true;
    # Makes directories not bold. There are icons, who cares.
    home.sessionVariables.EXA_COLORS = "di=34";
  };
}
