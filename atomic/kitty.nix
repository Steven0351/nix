{ config, ... }: {
  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_family = "JetBrainsMono Nerd Font";
    italic_font = "JetBrainsMono Nerd Font Italic";
    bold_font = "JetBrainsMono Nerd Font SemiBold";
    bold_italic_font = "JetBrainsMono Nerd Font SemiBold Italic";
    font_size = "14";
    adjust_line_height = "1";
    adjust_column_width = "0";

    symbol_map = "U+f8e1 Font Awesome 5 Brands";

    cursor_shape = "block";
    cursor_blink_interval = "1.0";
    cursor_stop_blinking_after = "15.0";

    enable_audio_bell = true;
    window_alert_on_bell = true;
    bell_on_tab = true;

    enabled_layouts = "tall,horizontal";
    window_border_width = "2";
    window_margin_width = "1";
    window_padding_width = "0 5 3";
    tab_bar_margin_width = "4";
    tab_bar_style = "fade";
    tab_fade = "1 1 1";

    shell = "${config.home.homeDirectory}/.nix-profile/bin/fish";
    editor = "nvim";

    macos_titlebar_color = "background";
    macos_hide_titlebar = false;
    macos_quit_when_last_window_closed = true;

    # Theme
    active_border_color = "#9EC183";
    inactive_border_color = "#2E3440";

    foreground = "#E5E9F0";
    background = "#2E3440";
    selection_foreground = "#000000";
    selection_background = "#3F4758";
    url_color = "#88C0D0";
    cursor = "#81A1C1";

    active_tab_foreground = "#88C0D0";
    active_tab_background = "#434C5E";
    active_tab_font_style = "bold";

    inactive_tab_foreground = "#6C7A96";
    inactive_tab_background = "#2E3440";
    inactive_tab_font_style = "italic";

    kitty_mod = "opt+cmd";

    # black
    color0 = "#3B4252";
    color8 = "#4C566A";

    # red
    color1 = "#E06C75";
    color9 = "#E06C75";

    # green
    color2 = "#9EC183";
    color10 = "#9EC183";

    # yellow
    color3 = "#EBCB8B";
    color11 = "#EBCB8B";

    # blue
    color4 = "#81A1C1";
    color12 = "#81A1C1";

    # magenta
    color5 = "#81A1C1";
    color13 = "#81A1C1";

    # cyan
    color6 = "#88C0D0";
    color14 = "#8FBCBB";

    # white
    color7 = "#E5E9F0";
    color15 = "#ECEFF4";
  };

  programs.kitty.keybindings = {
    "kitty_mod+b" = "scroll_page_up";
    "kitty_mod+f" = "scroll_page_down";
    "kitty_mod+enter" = "new_window_with_cwd";
    "kitty_mod+j" = "previous_window";
    "kitty_mod+k" = "next_window";
    "kitty_mod+l" = "next_tab";
    "kitty_mod+h" = "previous_tab";
    "kitty_mod+t" = "new_tab_with_cwd";
    "kitty_mod+0" = "goto_layout tall";
    "kitty_mod+1" = "goto_layout horizontal";
    "kitty_mod+equal" = "change_font_size current +2.0";
    "kitty_mod+minus" = "change_font_size current -2.0";
    "kitty_mod+backspace" = "change_font_size current 0";
  };
}
