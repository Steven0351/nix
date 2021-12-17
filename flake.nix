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

    my-nixpkgs = {
      url = "github:Steven0351/nixpkgs-srs/main";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs: {
    darwinConfigurations = {
      macos-laptop = inputs.darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        inputs = inputs;
        modules = [
          (import ./macos-laptop/configuration.nix)
          inputs.home-manager.darwinModules.home-manager
        ];
      };
    };
  };
}
