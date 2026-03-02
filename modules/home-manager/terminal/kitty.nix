{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.kitty;
  inherit (lib) mkOption mkIf types;
  settingsValue =
    with types;
    oneOf [
      str
      bool
      int
      float
    ];
in
{
  options.terminal.kitty = {
    enable = mkOption {
      description = "enable kitty";
      type = types.bool;
      default = true;
    };

    themeFile = mkOption {
      description = "The kitty theme to use";
      type = types.str;
      default = "kanagawa_dragon";
    };

    font = mkOption {
      description = "The font to use";
      type = lib.hm.types.fontType;
      default = {
        name = "TX-02";
        size = 15;
      };
    };

    extraSettings = mkOption {
      description = "Addtional settings to add or override";
      type = types.attrsOf settingsValue;
      default = { };
    };

    extraConfig = mkOption {
      description = "Additional plain-text config";
      type = types.lines;
      default = "";
    };

    extraKeybindings = mkOption {
      description = "Additional keybindings";
      type = types.attrsOf types.str;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    programs.kitty.enable = true;
    programs.kitty.themeFile = cfg.themeFile;
    programs.kitty.font = cfg.font;

    programs.kitty.settings = {
      cursor_shape = "block";
      cursor_blink_interval = "1.0";
      cursor_stop_blinking_after = "15.0";
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;

      enable_audio_bell = true;
      window_alert_on_bell = true;
      bell_on_tab = true;

      enabled_layouts = "tall,horizontal";
      window_border_width = "2";
      window_margin_width = "1";
      window_padding_width = "10 5 5";

      shell = "${pkgs.fish}/bin/fish";
      editor = "stevenvim";

      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = true;

      kitty_mod = "opt+cmd";
    }
    // cfg.extraSettings;

    programs.kitty.shellIntegration.mode = "no-cursor";
    programs.kitty.shellIntegration.enableFishIntegration = true;
    programs.kitty.extraConfig = cfg.extraConfig;

    programs.kitty.keybindings = {
      "kitty_mod+equal" = "change_font_size current +2.0";
      "kitty_mod+minus" = "change_font_size current -2.0";
      "kitty_mod+backspace" = "change_font_size current 0";
    }
    // cfg.extraKeybindings;
  };

}
