# Steven0351/nix
My nix configurations for my various systems. This was very much inspired the
configurations found at [jwoudenberg/nix](https://github.com/jwoudenberg/nix).

To build and switch changes made, run the following:

**macos-laptop**
 ```fish
 nix build .#darwinConfigurations.macos-laptop.system
./result/sw/bin/darwin-rebuild switch --flake .#macos-laptop
 ```

**mac-mini**
 ```fish
 nix build .#darwinConfigurations.mac-mini.system
./result/sw/bin/darwin-rebuild switch --flake .#mac-mini
 ```
