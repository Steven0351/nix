{ config, pkgs, inputs, ...}: {
  imports = [ ./brew.nix ];
  environment.systemPackages = [];

  services.nix-daemon.enable = true;

  programs.bash.enable = true;
  programs.fish.enable = true;

  environment.pathsToLink = [ "/share/fish" ];

  system.stateVersion = 4;

  nix = {
    maxJobs = 10;
    buildCores = 10;
    package = pkgs.nix;
    useSandbox = true;
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

  users.nix.configureBuildUsers = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.steven0351 = import ./home.nix;

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

  networking.hostName = "Atomic";
}
