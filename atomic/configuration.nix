{...}@inputs: { config, pkgs, ...}: {
  imports = [ ./brew.nix ];
  environment.systemPackages = [];

  services.nix-daemon.enable = true;

  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.openssh = {
    enable = true;
    stdoutPath = "/Users/steven0351/.ssh/stdout.log";
    stderrPath = "/Users/steven0351/.ssh/stderr.log";
  };

  environment.pathsToLink = [ "/share/fish" ];

  system.stateVersion = 4;

  nix = {
    settings = {
      sandbox = false;
      max-jobs = 10;
      cores = 10;
    };

    configureBuildUsers = true;
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      interval = {
        Weekday = 7;
      };
      options = "--delete-older-than 7d";
    };
  };

  users.users.steven0351 = {
    home = "/Users/steven0351";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.steven0351 = import ./home.nix inputs;

  nixpkgs.config.allowUnfree = true;

  system.defaults.dock = {
    autohide = true;
    mru-spaces = false;
    orientation = "left";
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages ++ config.home-manager.users.steven0351.home.packages;
    pathsToLink = "/Applications";
  });

  system.activationScripts.applications.text = pkgs.lib.mkForce (''
      echo "setting up ~/Applications/Nix..."
      rm -rf ~/Applications/Nix
      mkdir -p ~/Applications/Nix
      chown steven0351 ~/Applications/Nix
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
        src="$(/usr/bin/stat -f%Y $f)"
        appname="$(basename $src)"
        osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/steven0351/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');
  # Nix-darwin does not link installed applications to the user environment. This means apps will not show up
  # in spotlight, and when launched through the dock they come with a terminal window. This is a workaround.
  # Upstream issue: https://github.com/LnL7/nix-darwin/issues/214
  # system.activationScripts.applications.text = lib.mkForce ''
  #   echo "setting up ~/HomeManagerApps ..." >&2
  #   applications="$HOME/HomeManagerApps"
  #   nix_apps="$applications"
  #
  #   echo "$(whoami)"
  #   # Needs to be writable by the user so that home-manager can symlink into it
  #   if ! test -d "$applications"; then
  #       mkdir -p "$applications"
  #       chown steven0351: "$applications"
  #       chmod u+w "$applications"
  #   fi
  #
  #   # Delete the directory to remove old links
  #   rm -rf "$nix_apps"
  #   mkdir -p "$nix_apps"
  #   find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  #       while read src; do
  #           # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
  #           # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
  #           # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
  #           /usr/bin/osascript -e "
  #               set fileToAlias to POSIX file \"$src\" 
  #               set applicationsFolder to POSIX file \"$nix_apps\"
  #               tell application \"Finder\"
  #                   make alias file to fileToAlias at applicationsFolder
  #                   # This renames the alias; 'mpv.app alias' -> 'mpv.app'
  #                   set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
  #               end tell
  #           " 1>/dev/null
  #       done
  # '';

  networking.hostName = "Atomic";
}
