{ nixos-unstable, ... }@inputs:
{ config, pkgs, lib, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "amd_pstate=active"
    "processor.max_cstate=1"
    "nowatchdog"
    "nmi_watchdog=0"
    "split_lock_detect=off"
    "transparent_hugepage=always"
    "quiet"
    "loglevel=3"
    "mitigations=off"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
    "vm.compaction_proactiveness" = 0;
    "vm.watermark_boost_factor" = 1;
    "vm.page_lock_unfairness" = 1;
    "kernel.nmi_watchdog" = 0;
  };

  # CPU & Power
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # Graphics
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # GameMode
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
        inhibit_screensaver = 0;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Networking
  networking.hostName = "pulsar";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Shell
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  environment.pathsToLink = [ "/share/fish" ];

  # Users
  users.users.steven0351 = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
  };

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # Display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # YubiKey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.u2f = {
    enable = true;
    settings.cue = true;
  };

  security.pam.services.sudo.u2fAuth = true;
  security.pam.services.login.u2fAuth = true;
  security.pam.services.hyprlock = { };

  services.dbus.enable = true;

  environment.systemPackages = with pkgs; [
    git
    jj
    mangohud
    protonup-qt
    cpupower
    libfido2
  ];

  # Nix
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = [ "steven0351" ];
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

  # Home Manager
  home-manager.users.steven0351 = {
    imports = [
      (import ./home.nix inputs)
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  system.stateVersion = "25.05";
}
