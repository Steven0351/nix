# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ nixos-pkgs, ... }: { config, pkgs, lib, ... }:
{
  # Use the GRUB 2 boot loader.
  boot = {
    initrd = {
      availableKernelModules = [ "virtio_pci" "virtio_scsi" "ahci" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelParams = [ "console=tty50,19200n8" ];
    kernelModules = [ ];
    extraModulePackages = [ ];

    loader.grub = {
      enable = true;
      forceInstall = true;
      device = "nodev";
      timeout = 10;
      version = 2;
      extraConfig = ''
        serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
        terminal_input serial;
        terminal_output serial;
      '';
    };
  };

  fileSystems."/" =
    { device = "/dev/sda";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/sdb"; }
    ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.tailscale.enable = true;

  services.gitea = {
    enable = true;
    domain = "nixos.panda-enigmatic.ts.net";
    rootUrl = "https://nixos.panda-enigmatic.ts.net/git";
    httpPort = 3333;
  };

  services.nginx.virtualHosts."nixos.panda-enigmatic.ts.net" = {
    forceSSL = true;
    sslCertificate = "/home/steven0351/nixos.panda-enigmatic.ts.net.crt";
    sslCertificateKey = "/home/steven0351/nixos.panda-enigmatic.ts.net.key";
    locations."/git" = {
      proxyPass = "http://localhost:3333";
    };
  };

  networking = {
    usePredictableInterfaceNames = false;
    useDHCP = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up --ssh -authkey $(cat /etc/tailscale.d/key)
    '';
  };
  networking.interfaces.eth0.useDHCP = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
    vim
    wget
    git
    tailscale
  ];

  environment.pathsToLink = [ "/share/bash-completion" ]; 

  # enable the tailscale service
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry.nixpkgs.flake = nixos-pkgs;
    nixPath = [ "nixpkgs=${nixos-pkgs}" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  users = {
    mutableUsers = false;

    users.steven0351 = {
      isNormalUser = true;
      home = "/home/steven0351";
      extraGroups = [ "wheel" ];
      hashedPassword = "$6$Gc1lK2mfMDCUnF3Q$noQ/j9S3uAU/rmcpb23P5wxyNQHMkYr0l3blazMGh9xoWgMQNZmBWOLKsSQ6fJrkN2sagqmsf92NHcg8osiaK.";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.steven0351 = import ./home.nix;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    permitRootLogin = "no";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
