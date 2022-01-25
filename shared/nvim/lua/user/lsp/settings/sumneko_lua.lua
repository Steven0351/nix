local handlers = require("user.lsp.handlers")

return require("lua-dev").setup {
  library = {
    vimruntime = true,
  },
  runtime_path = true,
  lspconfig = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  },
}
