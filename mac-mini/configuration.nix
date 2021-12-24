{ config, pkgs, inputs, ... }: {
  environment.systemPackages = [ ];

  services.nix-daemon.enable = true;

  programs.bash.enable = true;
  programs.fish.enable = true;

  environment.pathsToLink = [ "/share/fish" ];

  system.stateVersion = 4;

  nix = {
    maxJobs = 8;
    buildCores = 8;
    useSandbox = true;
    package = pkgs.nix_2_5;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      interval = { Weekday = 7; };
      options = "--delete-older-than 7d";
    };
  };

  users.users = {
    stevensherry.home = "/Users/stevensherry";
    build.home = "/Users/build";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.stevensherry = import ./home.nix;

  nixpkgs.config.allowUnfree = true;
}
