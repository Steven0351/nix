inputs: { config, lib, pkgs, nixos-pkgs, ...}: {
  
  imports = [ ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/ed518c26-fe9f-4223-8532-c305fb50daec";
    fsType = "btrfs";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/1853-0E5B";
    fsType = "vfat";
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/bce1002e-ebab-4f87-ab29-62da9f6770de"; }
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "nixos-x86-vm";
  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  
  environment.pathsToLink = [ "/share/fish" ]; # Needed for fish setup

  nixpkgs.config.allowUnfree = true;

  nix = {
    registry.nixpkgs.flake = nixos-pkgs;
    nixPath = [ "nixpkgs=${nixos-pkgs}" ];
    gc = {
      automatic = true;
      date = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nix_2_4;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  users.mutableUsers = false;

  users.users.steven0351 = {
    isNormalUser = true;
    home = "/home/steven0351";
    groups = [ "wheel" ];
    hashedPassword = "$6$ovF47m7mqBGepnA0$/eeLRGyyOiIOEcdZS8iPxGnFH.VjWOWVGe.NDaCeYYdzJc16QN/nHalUGfe.fo2RxgF06RA4y5V.pefFgx04.1";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.steven0351 = import ./home.nix;
  
  system.stateVersion = "21.11"; # Don't change this unless you want pain and suffering
  system.autoUpgrade.enable = false;
}

