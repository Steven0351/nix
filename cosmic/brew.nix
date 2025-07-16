{
  homebrew = {
    enable = true;

    brews = [
      {
        name = "sketchybar";
        restart_service = true;
        start_service = true;
      }
    ];

    taps = [
      { 
        name = "FelixKratz/formulae";
      }
    ];

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    global = {
      brewfile = true;
    };

    casks = [
      "ghostty"
      "hammerspoon"
      "notion"
      "slack"
      "tailscale"
      "vlc"
      "zoom"
      "wezterm"
    ];

    extraConfig = ''
      cask_args appdir: "~/Applications", require_sha: true
    '';
  };
}
