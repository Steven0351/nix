{ config, ... }: {
  xsession = {
    enable = true;
    
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.xmonad-contrib
        hp.monad-logger
      ];
      config = ./xmonad.hs;
    };
  };

  programs.xmobar = {
    enable = true;
    extraConfig = ''
    -- http://projects.haskell.org/xmobar/

    Config { font    = "xft:Fira:weight=bold:pixelsize=14:antialias=true:hinting=true"
           , additionalFonts = [ "xft:Fira Code Nerd Font:pixelsize=12:antialias=true:hinting=true"
                               , "xft:Font Awesome 5 Free Solid:pixelsize=14"
                               , "xft:Font Awesome 5 Brands:pixelsize=14"
                               ]
           , bgColor = "#2E3440"
           , fgColor = "#EBCB8B"
           , position = TopSize C 100 28 
           , lowerOnStart = True
           , hideOnStart = False
           , allDesktops = True
           , persistent = True
           , iconRoot = "${config.xdg.dataHome}/xpm" 
           , commands = [
                        -- Time and date
                          Run Date "<fn=2>\xf783</fn>  %b %d %Y - (%H:%M) " "date" 50
                          -- Cpu usage in percent
                        , Run Cpu ["-t", "<fn=2>\xf2db</fn>  cpu: (<total>%)","-H","50","--high","red"] 20
                          -- Ram used number and percent
                        , Run DiskU [("/", "<fn=2>\xf0a0</fn>  hdd: <free> free")] [] 60
                          -- Runs a standard shell command 'uname -r' to get kernel version
                        , Run Com "uname" ["-r"] "" 3600
                        , Run UnsafeStdinReader
                        ]
           , sepChar = "%"
           , alignSep = "}{"
           , template = " <icon=code.xpm/> <fc=#4C566A>|</fc> %UnsafeStdinReader% }{  <fc=#4C566A>|</fc>  <fc=#D8DEE9><fn=3></fn>  <action=`kitty -e btop`>%uname%</action> </fc> <fc=#4C566A>|</fc>  <fc=#EBCB8B> <action=`kitty -e btop`>%cpu%</action> </fc> <fc=#4C566A>|</fc> <fc=#88C0D0> <action=`kitty -e btop`>%disku%</action> </fc> <fc=#4C566A>|</fc> <fc=#81A1C1> <action=`kitty -e date`>%date%</action> </fc>"
           }
    '';
  };

  xdg.dataFile.xpm = {
    source = ./xpm;
    recursive = true;
  };
}
