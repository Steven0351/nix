local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local sumneko_opts = require "user.lsp.settings.sumneko_lua"
lspconfig.sumneko_lua.setup(sumneko_opts)
lspconfig.rnix.setup {}
lspconfig.tailwindcss.setup {}
lspconfig.svelte.setup {}

require "user.lsp.diagnostics"
require "user.lsp.null-ls"
