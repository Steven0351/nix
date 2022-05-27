local au_opts = { clear = true }
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general_settings = augroup("_general_settings", au_opts)

autocmd("FileType", {
  group = general_settings,
  pattern = { "qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<CR>"
})

autocmd("TextYankPost", {
  group = general_settings,
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank({
      higroup = 'Visual',
      timeout = 200,
    })
  end
})

autocmd("BufWinEnter", {
  group = general_settings,
  pattern = "*",
  command = ":set formatoptions-=ro"
})

autocmd("FileType", {
  group = general_settings,
  pattern = "qf",
  command = "set nobuflisted"
})

local prose = augroup("_prose", au_opts)

autocmd("FileType", {
  group = prose,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

local auto_resize = augroup("_auto_resize", au_opts)

autocmd("VimResized", {
  group = auto_resize,
  pattern = "*",
  command = "tabdo wincmd ="
})

local file_types = augroup("_file_types", au_opts)

autocmd("BufRead,BufNewFile", {
  group = file_types,
  pattern = { "Podfile", "*.podspec" },
  command = "set filetype=ruby"
})

local lsp_signature = augroup("_lsp_signature", au_opts)

autocmd("InsertEnter", {
  group = lsp_signature,
  pattern = "*",
  callback = function()
    require("lsp_signature").on_attach()
  end
})

local rust_tools = augroup("_rust_tools", au_opts)

autocmd("BufRead,BufNewFile", {
  group = rust_tools,
  pattern = "*.rs",
  callback = function()
    require("rust-tools").setup {}
  end
})

vim.cmd [[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _nvim_tree
    autocmd!
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
