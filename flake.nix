{
  description = "My Nix Environment";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    jj.url = "github:jj-vcs/jj/v0.36.0";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    nixos-pkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixos-pkgs";
    };

    nixos-unstable.url = "github:nixos/nixpkgs/nixos-25.11";

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    home-manager-nixos-unstable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    stevenvim.url = "github:Steven0351/steve.nvim";
    tmux-thumbs.url = "github:Steven0351/tmux-thumbs";
    nerdfont-search.url = "github:Steven0351/nerdfont-search";
    quickemu.url = "github:quickemu-project/quickemu";

    kanagawa-tmux = {
      url = "github:Steven0351/kanagawa-tmux/kanagawa";
      flake = false;
    };
  };

  outputs =
    {
      self,
      darwin,
      home-manager,
      home-manager-nixos,
      home-manager-nixos-unstable,
      nixos-pkgs,
      nixos-unstable,
      nixos-wsl,
      tmux-thumbs,
      jj,
      stevenvim,
      quickemu,
      kanagawa-tmux,
      nerdfont-search,
      ...
    }@inputs:

    let
      overlay = final: prev: {
        tmuxPlugins = prev.tmuxPlugins // {
          thumbs = tmux-thumbs.packages."${prev.stdenv.hostPlatform.system}".default;
          kanagawa = prev.tmuxPlugins.mkTmuxPlugin {
            pluginName = "kanagawa-tmux";
            version = "0.1.0";
            rtpFilePath = "kanagawa.tmux";
            src = kanagawa-tmux;
          };
        };

        jj = jj.packages."${prev.stdenv.hostPlatform.system}".jujutsu;

        kitty-themes = prev.kitty-themes.overrideAttrs (oldAttrs: {
          postInstall = ''
            cp -r ${kanagawa-tmux}/extras/kitty/* $out/share/kitty-themes/themes
          '';
        });
      };

      alteredPkgs =
        { ... }:
        {
          nixpkgs.overlays = [
            overlay
            nerdfont-search.overlays.default
            stevenvim.overlays.default
            stevenvim.overlays.jjedit
            quickemu.overlays.default
          ];
        };

      homeManagerModules = {
        home-manager.sharedModules = [
          ./modules/home-manager/wallpapers
          ./modules/home-manager/terminal
        ];
      };
    in

    {
      darwinConfigurations = {
        mac-mini = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inputs = inputs;
          modules = [
            alteredPkgs
            (import ./mac-mini/configuration.nix)
            home-manager.darwinModules.home-manager
            homeManagerModules
          ];
        };

        cosmic = darwin.lib.darwinSystem {
          inherit inputs;
          system = "aarch64-darwin";
          modules = [
            alteredPkgs
            ./modules/nix-darwin
            (import ./cosmic/configuration.nix)
            home-manager.darwinModules.home-manager
            homeManagerModules
          ];
        };
      };

      nixosConfigurations = {
        nixos-linode = nixos-pkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (import ./nixos-linode/configuration.nix inputs)
            home-manager-nixos.nixosModules.home-manager
          ];
        };

        nixos-wsl = nixos-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            (import ./nixos-wsl/wsl.nix inputs)
            home-manager-nixos-unstable.nixosModules.home-manager
          ];
        };

        pulsar = nixos-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            alteredPkgs
            (import ./pulsar/configuration.nix inputs)
            home-manager-nixos-unstable.nixosModules.home-manager
            homeManagerModules
          ];
        };

        pulsar-iso = nixos-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${nixos-unstable}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            alteredPkgs
            (import ./pulsar/configuration.nix inputs)
            home-manager-nixos-unstable.nixosModules.home-manager
            homeManagerModules
            (
              { lib, ... }:
              {
                boot.loader.systemd-boot.enable = lib.mkForce false;
                boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
                boot.supportedFilesystems.zfs = lib.mkForce false;
              }
            )
          ];
        };
      };

      packages.aarch64-darwin.default = self.darwinConfigurations.cosmic.system;
    };
}
