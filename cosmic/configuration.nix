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
    orientation = "right";
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  networking.hostName = "Cosmic";
}
