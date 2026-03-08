{ nixos-unstable, ... }@inputs:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  me = "steven0351";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs._1password-shell-plugins.nixosModules.default
  ];

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

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
    "vm.compaction_proactiveness" = 0;
    "vm.watermark_boost_factor" = 1;
    "vm.page_lock_unfairness" = 1;
    "kernel.nmi_watchdog" = 0;
  };

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        ControllerMode = "dual";
        FastConnectable = true;
        JustWorksRepairing = "always";
        Class = "0x000100";
        ReconnectAttempts = 7;
        ReconnectIntervals = "1,2,4,8,16,32,64";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # TODO: Remove at some point
  services.blueman.enable = true;

  programs.gpu-screen-recorder.enable = true;

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
    wireplumber = {
      enable = true;
      extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.codecs" = [
            "sbc"
            "sbc_xq"
            "aac"
            "ldac"
          ];
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };
    };
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
  users.mutableUsers = true;

  users.users."${me}" = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$ar/PiNiglR4LVagM4JQLo1$9GCYnNMsPtyPPM2Kjay2g5hWYbezn4KaWZRbZadWgf4";
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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
  services.udev.packages = [
    pkgs.yubikey-personalization
  ];

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
    libfido2
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ me ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  # Nix
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = [ me ];
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

  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [ gh ];
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ me ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        chromium
      '';
      mode = "0755";
    };
  };

  programs.nix-ld.enable = true;

  # Home Manager
  home-manager.users."${me}" = import ./home.nix;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  system.stateVersion = "25.05";
}
