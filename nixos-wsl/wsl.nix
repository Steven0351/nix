{ nixos-unstable, ... }: { pkgs, ... }: {
  time.timeZone = "America/Chicago";

  networking.hostName = "work";

  programs.fish.enable = true;
  environment.pathsToLink = [ "/share/fish" ];
  environment.shells = [ pkgs.fish ];
  environment.enableAllTerminfo = true;

  security.sudo.wheelNeedsPassword = false;

  users.users."steven0351" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  home-manager.users."steven0351" = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05";

  wsl = {
    enable = true;
    defaultUser = "steven0351";
    startMenuLaunchers = true;
    wslConf.interop.appendWindowsPath = false;
  };

  nix = {
    settings = {
      trusted-users = ["steven0351"];
      accept-flake-config = true;
      auto-optimise-store = true;

    };

    registry = {
      nixpkgs = {
        flake = nixos-unstable;
      };
    };

    nixPath = [
      "nixpkgs=${nixos-unstable.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
