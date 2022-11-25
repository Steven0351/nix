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

    taps = [ "homebrew/cask" ];

    casks = [
      "amethyst"
      "firefox"
      "iterm2"
      "notion"
      "qutebrowser"
      "slack"
      "tailscale"
      "vlc"
      "zoom"
    ];

    extraConfig = ''
      cask_args appdir: "~/Applications", require_sha: true
    '';
  };
}
