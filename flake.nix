{
  description = "My Nix Environment";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    jj.url = "github:jj-vcs/jj/v0.34.0";

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

    nixos-unstable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    home-manager-nixos-unstable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    stevenvim.url = "github:Steven0351/steve.nvim";
    tmux-thumbs.url = "github:Steven0351/tmux-thumbs";
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
      ...
    }@inputs:
    let
      overlay = final: prev: {
        tmuxPlugins = prev.tmuxPlugins // {
          thumbs = tmux-thumbs.packages."${prev.system}".default;
        };
        jj = jj.packages."${prev.system}".jujutsu;
        stevenvim = stevenvim.packages."${prev.system}".default;
        jjedit = stevenvim.packages."${prev.system}".jjedit;
      };
      alteredPkgs =
        { ... }:
        {
          nixpkgs.overlays = [ overlay ];
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
      };
    };
}
