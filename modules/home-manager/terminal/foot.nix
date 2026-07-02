{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.foot;
  inherit (lib) mkOption mkIf types;
in
{
  options.terminal.foot = {
    enable = mkOption {
      description = "enable foot";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.foot.enable = true;
    programs.foot.settings = {
      main = {
        font = "TX02NerdFont-Thin:size=13";
        pad = "8x8 center";
        dpi-aware = "yes";
      };

      colors-dark = {
        background = "161716";
        foreground = "D6D6D6";
        regular0 = "161716";
        regular1 = "B49273";
        regular2 = "85B884";
        regular3 = "BDBBAF";
        regular4 = "A2B5C1";
        regular5 = "ABBAB5";
        regular6 = "60B197";
        regular7 = "B5B5B5";
        
        bright0 = "727272";
        bright1 = "E06C75";
        bright2 = "8EC772";
        bright3 = "D6BD87";
        bright4 = "6196C2";
        bright5 = "AA749F";
        bright6 = "BAD7FF";
        bright7 = "E1E1E1";

        selection-background = "373737";
        selection-foreground = "E1E1E1";
      };
# cursor-color = #C1C1C1
# cursor-text = #161716
    };
  };
}
