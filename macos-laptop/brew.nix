{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [ "homebrew/cask" ];
    brews = [ "mas" ];

    casks = [
      "amethyst"
      "hammerspoon"
      "kitty"
      "qutebrowser"
    ];

    masApps = {
      Tailscale = 1475387142;
    };

    extraConfig = ''
      cask_args appdir: "~/Applications", require_sha: true
    '';
  };
}
