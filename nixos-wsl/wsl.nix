{ nixos-unstable, ... }@inputs:
{ pkgs, ... }:
{
  time.timeZone = "America/Chicago";

  networking.hostName = "work";

  programs.fish.enable = true;
  programs.ssh = {
    startAgent = false;
    extraConfig = ''
      IdentityAgent none
    '';
  };
  environment.pathsToLink = [ "/share/fish" ];
  environment.shells = [ pkgs.fish ];
  environment.enableAllTerminfo = true;
  environment.systemPackages = with pkgs; [
    yubikey-manager
    libfido2
  ];

  services = {
    openssh.enable = false;
    pcscd.enable = false;
    udev = {
      enable = false;
      packages = [ pkgs.yubikey-personalization ];
      extraRules = ''
        SUBSYSTEM=="usb", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", TAG+="uaccess", MODE="0666"
      '';
    };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users."nixos" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  home-manager.users."nixos" = {
    imports = [
      (import ./home.nix inputs)
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  system.stateVersion = "25.05";

  wsl = {
    enable = true;
    defaultUser = "nixos";
    usbip = {
      enable = false;
      autoAttach = [ "6-2" ];
    };
    startMenuLaunchers = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = [ "nixos" ];
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
