# My Neovim Config

Generated from [LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)

Requires nodejs for some LSP servers to work.

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll may notice you don't have support for copy/paste

First we'll fix copy/paste

- On mac `pbcopy` should be builtin
- On nixOS in home-manager config:
  ```
  home.packages = with pkgs; [
    xsel
  ]
  ```

Next we need to install python support (node is optional)

- Neovim node support
  ```
  home.packages = with pkgs; [
    nodePackages.neovim
  ]
  ```

---

> The computing scientist's main challenge is not to get confused by the complexities of his own making.

\- Edsger W. Dijkstra
