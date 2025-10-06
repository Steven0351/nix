{
  homebrew = {
    enable = true;

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
      "tailscale"
      "vlc"
      "wezterm"
    ];

    extraConfig = ''
      cask_args appdir: "~/Applications", require_sha: true
    '';
  };
}
