inputs: { config, lib, pkgs, ...}: {
  
  imports = [ ./sys-xmonad.nix ];
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };
    
    kernelModules =  [ ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = { 
    device = "/dev/sda1";
    fsType = "btrfs";
  };

  fileSystems."/boot" = { 
    device = "/dev/sda3";
    fsType = "vfat";
  };

  swapDevices = [ 
    { device = "/dev/sda2"; }
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "nixos-x86-vm"; 
    useDHCP = false;
    interfaces.ens33.useDHCP = true;
  };

  time.timeZone = "America/Chicago";

  environment = {
    systemPackages = with pkgs; [
      vim
      git
    ];

    pathsToLink = [ "/share/fish" ]; # Needed for fish setup
  };
  
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry.nixpkgs.flake = inputs.nixos-pkgs;
    nixPath = [ "nixpkgs=${inputs.nixos-pkgs}" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nix_2_4;
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
      hashedPassword = "$6$ovF47m7mqBGepnA0$/eeLRGyyOiIOEcdZS8iPxGnFH.VjWOWVGe.NDaCeYYdzJc16QN/nHalUGfe.fo2RxgF06RA4y5V.pefFgx04.1";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.steven0351 = import ./home.nix;
  };

  system = {
    stateVersion = "21.11"; # Don't change this unless you want pain and suffering
    autoUpgrade.enable = false;
  };
}

