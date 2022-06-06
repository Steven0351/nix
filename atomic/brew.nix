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

    casks = [
      "amethyst"
      "firefox"
      "iterm2"
      "kitty"
      "notion"
      "slack"
      "zoom"
    ];

    extraConfig = ''
      cask_args appdir: "~/Applications", require_sha: true
    '';
  };
}
