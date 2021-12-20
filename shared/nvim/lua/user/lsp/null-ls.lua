local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

local h = require("null-ls.helpers")

local nixpkgs_fmt = {}
nixpkgs_fmt.method = null_ls.methods.FORMATTING
nixpkgs_fmt.filetypes = { "nix" }
nixpkgs_fmt.generator = h.formatter_factory({
  cmd = "nixpkgs-fmt",
  to_stdin = true,
})

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    nixpkgs_fmt,
    -- diagnostics.flake8
  },
})
