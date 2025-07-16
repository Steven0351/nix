{
  description = "My Nix Environment";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "unstable";
    };

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    nixos-pkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixos-pkgs";
    };

    nixd.url = "github:nix-community/nixd";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs: {
    darwinConfigurations = {
      macos-laptop = inputs.darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        inputs = inputs;
        modules = [
          ./shared/modules/nix-darwin
          (import ./macos-laptop/configuration.nix)
          inputs.home-manager.darwinModules.home-manager
        ];
      };

      mac-mini = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        inputs = inputs;
        modules = [
          (import ./mac-mini/configuration.nix)
          inputs.home-manager.darwinModules.home-manager
        ];
      };

      atomic = inputs.darwin.lib.darwinSystem {
        inherit inputs;
        system = "aarch64-darwin";
        modules = [
          ./shared/modules/nix-darwin
          (import ./atomic/configuration.nix inputs)
          inputs.home-manager.darwinModules.home-manager
        ];
      };

      cosmic = inputs.darwin.lib.darwinSystem {
        inherit inputs;
        system = "aarch64-darwin";
        modules = [
          ./shared/modules/nix-darwin
          (import ./cosmic/configuration.nix inputs)
          inputs.home-manager.darwinModules.home-manager {
            home-manager.sharedModules = [
              inputs.catppuccin.homeModules.catppuccin
            ];
          }
        ];
      };
    };

    nixosConfigurations = {
      nixos-x86-vm = inputs.nixos-pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./nixos-x86-vm/configuration.nix inputs)
          inputs.home-manager-nixos.nixosModules.home-manager
        ];
      };
      nixos-linode = inputs.nixos-pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./nixos-linode/configuration.nix inputs)
          inputs.home-manager-nixos.nixosModules.home-manager
        ];
      };
    };

    devShell =
      let
        mkDevShell = arch:
          let pkgs = inputs.unstable.legacyPackages."${arch}";
          in pkgs.mkShell {
            buildInputs = [
              pkgs.sumneko-lua-language-server
            ];
          };
      in
      {
        "x86_64-darwin" = mkDevShell "x86_64-darwin";
        "aarch64-darwin" = mkDevShell "aarch64-darwin";
        "x86_64-linux" = mkDevShell "x86_64-linux";
        "aarch64-linux" = mkDevShell "aarch64-linux";
      };
  };
}
