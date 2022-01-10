## Steven0351/nix

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

### Updating neovim configuration

It's a pain to edit neovim configuration and then have to create a new generation
to see if the update is actually what I want or need. To quickly iterate on configuration
changes run the following:

```fish
./edit-neovim-config
```

This script will open neovim with `./shared` as `XDG_CONFIG_HOME` so the `./shared/nvim`
directory is used for loading all the config files. `nvim -u ./shared/nvim/init.lua`
does not work because it will still try to source files from `~/.config/nvim`.
