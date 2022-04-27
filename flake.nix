{
  description = "My Nix Environment";

  nixConfig = {
    extra-substituters = [
      "https://cachix.cachix.org"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    nixos-pkgs.url = "github:nixos/nixpkgs/nixos-21.11";

    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixos-pkgs";
    };
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
        system = "aarch64-darwin";
        inputs = inputs;
        modules = [
          ./shared/modules/nix-darwin
          (import ./atomic/configuration.nix)
          inputs.home-manager.darwinModules.home-manager
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
    };

    devShell =
      let
        mkDevShell = pkgs:
          pkgs.mkShell {
            buildInputs = with pkgs; [
              sumneko-lua-language-server
              # (callPackage ./shared/sumneko-lua-ls {})
              rnix-lsp
            ];
          };
      in
      {
        "x86_64-darwin" = mkDevShell
          inputs.unstable.legacyPackages."x86_64-darwin";
        "aarch64-darwin" = mkDevShell
          inputs.unstable.legacyPackages."aarch64-darwin";
        "x86_64-linux" = mkDevShell
          inputs.nixos-pkgs.legacyPackages."x86_64-linux";
        "aarch64-linux" = mkDevShell
          inputs.nixos-pkgs.legacyPackages."aarch64-linux";
      };
  };
}
