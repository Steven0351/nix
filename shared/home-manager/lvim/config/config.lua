--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "onenord"
vim.opt.relativenumber = true

require("user.alpha")
require("user.autocommands")
require("user.keys")
require("user.lsp")
require("user.lvim-builtins")
require("user.plugins")
