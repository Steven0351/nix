{ config, ... }: {
  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_family = "FiraCode Nerd Font"; 
    italic_font = "FiraCode Nerd Font Italic";
    font_size = "13.5";
    adjust_line_height = "-2";
    adjust_column_width = "1";

    symbol_map = "U+f8e1 Font Awesome 5 Brands";

    cursor_shape = "block";
    cursor_blink_interval = "1.0";
    cursor_stop_blinking_after = "15.0";

    enable_audio_bell = true;
    window_alert_on_bell = true;
    bell_on_tab = true;

    enabled_layouts = "tall,horizontal";
    window_border_width = "3";
    window_margin_width = "2";
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
    active_border_color = "#A3BE8C";
    inactive_border_color = "#2E3440";

    foreground = "#D8DEE9";
    background = "#2E3440";
    selection_foreground = "#000000";
    selection_background = "#FFFACD";
    url_color = "#0087BD";
    cursor = "#E5E9F0";

    active_tab_foreground = "#A3BE8C";
    active_tab_background = "#3B4252";
    active_tab_font_style = "bold";

    inactive_tab_foreground = "#E5E9F0";
    inactive_tab_background = "#3B4252";
    inactive_tab_font_style = "italic";

    kitty_mod = "opt+cmd";

    # black
    color0 = "#3B4252";
    color8 = "#4C566A";

    # red
    color1 = "#BF616A";
    color9 = "#BF616A";

    # green
    color2 = "#A3BE8C";
    color10 = "#A3BE8C";

    # yellow
    color3 = "#EBCB8B";
    color11 = "#EBCB8B";

    # blue
    color4 = "#81A1C1";
    color12 = "#81A1C1";

    # magenta
    color5 = "#B48EAD";
    color13 = "#B48EAD";

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
