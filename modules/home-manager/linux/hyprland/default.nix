{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.hyprland;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.hyprland = {
    enable = mkEnableOption "hyprland desktop";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      grimblast
      dunst
      libnotify
      vicinae
      wl-clipboard
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      xwayland = {
        enable = true;
      };

      settings = {
        monitor = ",preferred,auto,1.25";

        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$launcher" = "vicinae open";

        xwayland = {
          force_zero_scaling = true;
        };

        exec-once = [
          "swww-daemon"
          "hypridle"
          "dunst"
          "1password --silent"
          "vicinae server"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(7e9cd8ff) rgba(957fb8ff) 45deg";
          "col.inactive_border" = "rgba(16161dff)";
          resize_on_border = true;
          layout = "dwindle";
        };

        decoration = {
          rounding = 8;
          inactive_opacity = 0.92;
          blur = {
            enabled = true;
            passes = 2;
          };
        };

        animations = {
          enabled = true;
          bezier = "smooth, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, smooth"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        input = {
          kb_layout = "us";
          accel_profile = "adaptive";
          natural_scroll = true;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        bind = [
          "$mod, Return, exec, $terminal"
          "$mod, Q, killactive"
          "$mod, Space, exec, $launcher"

          "$mod SHIFT, H, swapwindow, l"
          "$mod SHIFT, L, swapwindow, r"
          "$mod SHIFT, J, swapwindow, d"
          "$mod SHIFT, K, swapwindow, u"

          "$mod, N, cyclenext,"
          "$mod, P, cyclenext, prev"

          "$mod SHIFT, N, workspace, +1"
          "$mod SHIFT, P, workspace, -1"

          "$mod, F, fullscreen"
          "$mod, V, togglefloating"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"

          ", Print, exec, grimblast copy area"
          "$mod SHIFT, S, exec, grimblast copy area"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };

    programs.ashell = {
      enable = true;
      systemd.enable = true;
      systemd.target = "hyprland-session.target";
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = [
          {
            monitor = "";
            color = "rgba(16, 16, 29, 1.0)";
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 50";
            position = "0, -80";
            halign = "center";
            valign = "center";
            outline_thickness = 2;
            "col.outer" = "rgba(7e9cd8ff)";
            "col.inner" = "rgba(22222eff)";
            "col.text" = "rgba(dcd7baff)";
            placeholder_text = "Password";
          }
        ];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
