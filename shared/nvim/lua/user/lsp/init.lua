local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers = require "user.lsp.handlers"

local sumneko_opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

local lua_dev_opts = require("lua-dev").setup {
  lspconfig = sumneko_opts,
  runtime_path = true,
}

lspconfig.sumneko_lua.setup(lua_dev_opts)
lspconfig.rnix.setup {}

require "user.lsp.lsp-installer"
handlers.setup()
require "user.lsp.null-ls"
