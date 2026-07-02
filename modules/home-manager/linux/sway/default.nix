{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.sway;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.sway = {
    enable = mkEnableOption "sway desktop";
  };

  config = mkIf cfg.enable {
    desktop.enable = true;
    home.packages = with pkgs; [
      grim
      slurp
      foot
      mako
      playerctl
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = null;

      config = let
        mod = "Mod4";
        alt = "Mod1";
        hyper = "Mod4+Mod1+Shift+Ctrl";
      in rec {
        # We don't need no stinking bars
        bars = [];
        modifier = mod;
        # TODO: use foot
        # terminal = "foot";
        terminal = "ghostty";
        left = "h";
        right = "l";
        up = "k";
        down = "j";

        defaultWorkspace = "workspace number 1";
        

        input = {
          "type:pointer" = {
            natural_scroll = "enabled";
          };
        };

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${mod}+q" = "kill";
          "${mod}+Space" = "exec ${menu}";

          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";

          "${hyper}+${left}" = "focus parent; focus left";
          "${hyper}+${right}" = "focus parent; focus right";
          "${hyper}+${up}" = "focus parent; focus up";
          "${hyper}+${down}" = "focus parent; focus down";

          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";

          "${mod}+${alt}+${right}" = "resize shrink width 50 px";
          "${mod}+${alt}+${left}" = "resize grow width 50 px";
          "${mod}+${alt}+${down}" = "resize grow height 50 px";
          "${mod}+${alt}+${up}" = "resize shrink height 50 px";

          "${mod}+Ctrl+${left}" = "focus left; splith; focus right; move left; layout tabbed";
          "${mod}+Ctrl+${right}" = "focus right; splith; focus left; move right; layout tabbed";
          "${mod}+Ctrl+${up}" = "focus up; splitv; focus down; move up; layout tabbed";
          "${mod}+Ctrl+${down}" = "focus down; splitv; focus up; move down; layout tabbed";

          "${mod}+i" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+Shift+f" = "inhibit_fullscreen toggle";
          "${mod}+f" = "fullscreen toggle";

          # the mnemonic here is "up" and "down"
          "${mod}+u" = "focus parent";
          "${mod}+d" = "focus child";

          "${mod}+t" = "layout tabbed";
          "${mod}+e" = "layout toggle splith splitv tabbed";

          "${mod}+Shift+x" = "floating toggle";
          "${mod}+x" = "focus mode_toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${hyper}+1" = "mark s1;  move scratchpad";
          "${hyper}+2" = "mark s2;  move scratchpad";
          "${hyper}+3" = "mark s3;  move scratchpad";
          "${hyper}+4" = "mark s4;  move scratchpad";
          "${hyper}+5" = "mark s5;  move scratchpad";
          "${hyper}+6" = "mark s6;  move scratchpad";
          "${hyper}+7" = "mark s7;  move scratchpad";
          "${hyper}+8" = "mark s8;  move scratchpad";
          "${hyper}+9" = "mark s9;  move scratchpad";
          "${hyper}+0" = "mark s10; move scratchpad";

          "${mod}+Ctrl+1" = ''[con_mark="s1"] scratchpad show'';
          "${mod}+Ctrl+2" = ''[con_mark="s2"] scratchpad show'';
          "${mod}+Ctrl+3" = ''[con_mark="s3"] scratchpad show'';
          "${mod}+Ctrl+4" = ''[con_mark="s4"] scratchpad show'';
          "${mod}+Ctrl+5" = ''[con_mark="s5"] scratchpad show'';
          "${mod}+Ctrl+6" = ''[con_mark="s6"] scratchpad show'';
          "${mod}+Ctrl+7" = ''[con_mark="s7"] scratchpad show'';
          "${mod}+Ctrl+8" = ''[con_mark="s8"] scratchpad show'';
          "${mod}+Ctrl+9" = ''[con_mark="s9"] scratchpad show'';
          "${mod}+Ctrl+0" = ''[con_mark="s10"] scratchpad show'';

          "${mod}+Shift+s" = "exec fish -c '${pkgs.grim}/bin/grim -g (${pkgs.slurp}/bin/slurp) - | ${pkgs.swappy}/bin/swappy -f -'";

          "${mod}+${alt}+s" = "move scratchpad";
          "${mod}+s" = "scratchpad show";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl prev";
        };

        modes = {};

        colors = {
          background = "#161716";
          
          focused = rec {
            background = "#4c554c";
            border = background;
            childBorder = border;
            text = "#d6d6d6";
            indicator = text;
          };

          focusedInactive = rec {
            background = "#2e332e";
            border = background;
            childBorder = border;
            text = "#909090";
            indicator = text;
          };

          unfocused = rec {
            background = "#181B18";
            border = background;
            childBorder = border;
            text = "#909090";
            indicator = text;
          };

          urgent = rec {
            background = "#B49273";
            border = background;
            childBorder = border;
            text = "#d6d6d6";
            indicator = text;
          };
        };
        
        startup = [
          {command = "${pkgs.vicinae}/bin/vicinae server";}
          {command = "awww-daemon";}
          {command = "1password --silent";}
          {command = "mako";}
        ];

        window.commands = [
          {
            command = "floating enable";
            criteria = { title = "termfilechooser"; };
          }
        ];

        focus.wrapping = "yes";
        focus.newWindow = "focus";

        fonts = {
          names = [
            "Symbols Nerd Font Mono"
            "TX-02"
          ];
          
          size = 14.0;
        };
        
        gaps = {
          inner = 8;
          outer = 8;
        };

        menu = "vicinae open";
      };
    };

    programs.swaylock = {
      enable = true;
    };

    services.hypridle = let
      lock_cmd = "${pkgs.swaylock}/bin/swaylock -fF -i ${../../wallpapers/wallpapers/moon.png} -u";
    in
    {
      enable = true;
      settings = {
        general = {
          inherit lock_cmd;
          before_sleep_cmd = lock_cmd;
        };

        listener = [
          {
            timeout = 300;
            on-timeout = lock_cmd;
          }
          {
            timeout = 600;
            on-timeout = "${pkgs.sway}/bin/swaymsg output DP-2 disable";
            on-resume = "${pkgs.sway}/bin/swaymsg output DP-2 enable";
          }
        ];
      };
    };
  };
}
