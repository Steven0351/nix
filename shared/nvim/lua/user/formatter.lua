require("formatter").setup({
  filetype = {
    nix = {
      function()
        return {
          exe = "nixpkgs-fmt",
          stdin = true,
        }
      end,
    },
  },
})

vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.nix FormatWrite
  augroup END
]])
