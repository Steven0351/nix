{...}@inputs: { config, pkgs, ...}: {
  system.primaryUser = "steven0351";
  imports = [ ./brew.nix ];
  environment.systemPackages = [];

  services.jankyborders = {
    enable = true;
    inactive_color = "0xFF2A2A37";
    active_color = "0xFFC8C093";
    width = 7.0;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.victor-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];

  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.openssh = {
    enable = true;
    stdoutPath = "/Users/steven0351/.ssh/stdout.log";
    stderrPath = "/Users/steven0351/.ssh/stderr.log";
  };

  environment.pathsToLink = [ "/share/fish" ];
  system.stateVersion = 4;
  ids.gids.nixbld = 350;

  nix = {
    settings = {
      sandbox = false;
      max-jobs = 10;
      cores = 10;
    };

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
