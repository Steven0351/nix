local au_opts = { clear = true }

local general_settings = vim.api.nvim_create_augroup("_general_settings", au_opts)

vim.api.nvim_create_autocmd("FileType", {
  group = general_settings,
  pattern = { "qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<CR>"
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = general_settings,
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank({
      higroup = 'Visual',
      timeout = 200,
    })
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = general_settings,
  pattern = "*",
  command = ":set formatoptions-=ro"
})

vim.api.nvim_create_autocmd("FileType", {
  group = general_settings,
  pattern = "qf",
  command = "set nobuflisted"
})

local prose = vim.api.nvim_create_augroup("_prose", au_opts)

vim.api.nvim_create_autocmd("FileType", {
  group = prose,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

local auto_resize = vim.api.nvim_create_augroup("_auto_resize", au_opts)

vim.api.nvim_create_autocmd("VimResized", {
  group = auto_resize,
  pattern = "*",
  command = "tabdo wincmd ="
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
