{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mango;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.mango = {
    enable = mkEnableOption "mango desktop";
  };

  config = mkIf cfg.enable {
    desktop.enable = true;
    home.packages = with pkgs; [
      grim
      slurp
    ];
    
    wayland.windowManager.mango = {
      enable = true;
      
      autostart_sh = ''
      awww-daemon &
      dunst &
      1password --silent &
      vicinae server &
      '';

      settings = let hyper = "SUPER+SHIFT+ALT+CTRL"; in {
        # borders
        bordercolor = "0x16161dff";
        focuscolor = "0x957fb8ff";
        borderpx = 2;
        border_radius = 8;

        # gaps
        gappih = 8;
        gappiv = 8;
        gappoh = 10;
        gappov = 10;

        # window
        blur = 1;
        blur_optimized = 1;
        blur_params_num_passes = 2;
        focused_opacity = 1.0;
        unfocused_opacity = 0.85;

        animations = 1;
        animation_type_open = "zoom";
        animation_type_close = "zoom";

        mouse_natural_scrolling = 1;
        new_is_master = 0;
        
        bind = [
          "SUPER,Return,spawn,kitty"
          "SUPER,e,spawn,emacs"
          "SUPER,r,reload_config"
          "SUPER,q,killclient"
          "SUPER,Space,spawn,vicinae open"

          "SUPER+CTRL,l,spawn,swaylock"

          "${hyper},c,setlayout,center_tile"
          "${hyper},d,setlayout,dwindle"
          "${hyper},r,setlayout,right_tile"
          "${hyper},s,setlayout,scroller"
          
          "SUPER,f,togglefakefullscreen"
          "SUPER,s,toggle_scratchpad"
          "SUPER,m,minimized"
          "SUPER+SHIFT,m,restore_minimized"

          "SUPER+SHIFT,s,spawn_shell,grim -g (slurp) - | swappy -f -"

          "SUPER,h,focusdir,left"
          "SUPER,l,focusdir,right"
          "SUPER,j,focusdir,down"
          "SUPER,k,focusdir,up"
          
          "SUPER+SHIFT,h,exchange_client,left"
          "SUPER+SHIFT,l,exchange_client,right"
          "SUPER+SHIFT,j,exchange_client,down"
          "SUPER+SHIFT,k,exchange_client,up"

          "SUPER,n,focusstack,next"
          "SUPER,p,focusstack,prev"
          
          "SUPER+SHIFT,n,exchange_stack_client,next"
          "SUPER+SHIFT,p,exchange_stack_client,prev"

          "SUPER+ALT,h,resizewin,-50,0"
          "SUPER+ALT,l,resizewin,+50,0"
          
          "SUPER,1,view,1"
          "SUPER,2,view,2"
          "SUPER,3,view,3"
          "SUPER,4,view,4"
          "SUPER,5,view,5"
          "SUPER,6,view,6"
          "SUPER,7,view,7"
          "SUPER,8,view,8"
          "SUPER,9,view,9"

          "SUPER+SHIFT,1,tag,1"
          "SUPER+SHIFT,2,tag,2"
          "SUPER+SHIFT,3,tag,3"
          "SUPER+SHIFT,4,tag,4"
          "SUPER+SHIFT,5,tag,5"
          "SUPER+SHIFT,6,tag,6"
          "SUPER+SHIFT,7,tag,7"
          "SUPER+SHIFT,8,tag,8"
          "SUPER+SHIFT,9,tag,9"
          
          "SUPER+ALT,1,tagsilent,1"
          "SUPER+ALT,2,tagsilent,2"
          "SUPER+ALT,3,tagsilent,3"
          "SUPER+ALT,4,tagsilent,4"
          "SUPER+ALT,5,tagsilent,5"
          "SUPER+ALT,6,tagsilent,6"
          "SUPER+ALT,7,tagsilent,7"
          "SUPER+ALT,8,tagsilent,8"
          "SUPER+ALT,9,tagsilent,9"
        ];

        tagrule = [
          "id:1,layout_name:right_tile"
          "id:2,layout_name:dwindle"
          "id:3,layout_name:dwindle"
          "id:4,layout_name:monocle"
          "id:5,layout_name:center_tile"
          "id:6,layout_name:right_tile"
          "id:7,layout_name:deck"
        ];
      };
      
    };

    programs.swaylock = {
      enable = true;
    };

    services.swayidle = {
      enable = true;
      events = {
        # This is a hack to get force swayidle to connect to the bus properly
        # https://github.com/swaywm/swayidle/issues/198#issuecomment-4232600377
        "before-sleep" = "true";
      };
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 600;
          command = "${pkgs.mango}/bin/mmsg dispatch disable_monitor,DP-2";
          resumeCommand = "${pkgs.mango}/bin/mmsg dispatch enable_monitor,DP-2";
        }
      ];
    };
  };
}
