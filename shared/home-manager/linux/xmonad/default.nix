{
  xsession = {
    enable = true;
    
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.xmonad-contrib
      ];
      config = ./xmonad.hs;
    };
  };

  xdg.configFile.xmobar = {
    recursive = true;
    source = ./xmobar;
  };
}
