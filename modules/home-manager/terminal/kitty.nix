{ lib, config, ... }:
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

      shell = "${config.home.homeDirectory}/.nix-profile/bin/fish";
      editor = "stevenvim";

      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = true;

      kitty_mod = "opt+cmd";
    }
    // cfg.extraSettings;

    programs.kitty.shellIntegration.mode = "no-cursor";
    programs.kitty.shellIntegration.enableFishIntegration = true;

    programs.kitty.extraConfig = ''
      symbol_map U+23FB-U+23FE TX02 Nerd Font
      symbol_map U+2665 TX02 Nerd Font
      symbol_map U+26a1 TX02 Nerd Font
      symbol_map U+2b58 TX02 Nerd Font
      symbol_map U+E000-U+E00A TX02 Nerd Font
      symbol_map U+E0A0-U+E0A2 TX02 Nerd Font
      symbol_map U+E0A3 TX02 Nerd Font
      symbol_map U+E0B0-U+E0B3 TX02 Nerd Font
      symbol_map U+E0B4-U+E0C8 TX02 Nerd Font
      symbol_map U+E0CA TX02 Nerd Font
      symbol_map U+E0CC-U+E0D7 TX02 Nerd Font
      symbol_map U+E000-U+E0A9 TX02 Nerd Font
      symbol_map U+E300-U+E3E3 TX02 Nerd Font
      symbol_map U+E5FA-U+E6B7 TX02 Nerd Font
      symbol_map U+E700-U+E8EF TX02 Nerd Font
      symbol_map U+EA60-U+EC1E TX02 Nerd Font
      symbol_map U+ED00-U+EFCE TX02 Nerd Font
      symbol_map U+F000-U+F2FF TX02 Nerd Font
      symbol_map U+F300-U+F381 TX02 Nerd Font
      symbol_map U+F400-U+F533 TX02 Nerd Font
      symbol_map U+F500-U+FD46 TX02 Nerd Font
      symbol_map U+F0001-U+F1AF0 TX02 Nerd Font
    ''
    + cfg.extraConfig;

    programs.kitty.keybindings = {
      "kitty_mod+equal" = "change_font_size current +2.0";
      "kitty_mod+minus" = "change_font_size current -2.0";
      "kitty_mod+backspace" = "change_font_size current 0";
    }
    // cfg.extraKeybindings;
  };

}
