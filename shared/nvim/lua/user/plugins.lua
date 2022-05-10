local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  }
  use { "nvim-lua/popup.nvim" } -- An implementation of the Popup API from vim in Neovim
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" } -- Easily comment stuff
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "noib3/nvim-cokeline", tag = "v0.3.0" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "feline-nvim/feline.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }
  use { "antoinemadec/FixCursorHold.nvim" } -- This is needed to fix lsp doc highlight
  use { "folke/which-key.nvim" }
  use { "stevearc/dressing.nvim" }
  use { "mhartington/formatter.nvim" }

  use {
    "Steven0351/dotnvim",
    config = function()
      require("dotnvim").setup {}
    end
  }

  use {
    "rmehri01/onenord.nvim",
    config = function()
      local colors = require "onenord.colors"

      require("onenord").setup {
        custom_highlights = {
          TSNamespace = { fg = colors.purple },
        },
      }
    end,
  }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        width = 50,
      }
    end,
  }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/cmp-cmdline" } -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "tamago324/nlsp-settings.nvim" } -- language server settings defined in json for
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "InsertEnter",
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  }

  -- Makes sumneko_lua lsp configuration for working with neovim configuration
  -- and plugin development easier
  use { "folke/lua-dev.nvim" }

  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup {}
    end,
    ft = "rust",
  }

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use { "JoosepAlviste/nvim-ts-context-commentstring" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  use {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require("surround").setup { mappings_style = "sandwich" }
    end,
  }

  use { "ggandor/lightspeed.nvim" }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
