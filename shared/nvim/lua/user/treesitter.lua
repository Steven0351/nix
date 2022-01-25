local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    -- Shell
    "bash",
    "fish",
    -- C Family
    "c",
    "cpp",
    "llvm",
    -- Erlang/Elixir
    "heex",
    "surface",
    "elixir",
    "erlang",
    -- Web
    "css",
    "elm",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "svelte",
    "tsx",
    "typescript",
    -- JVM
    "java",
    "kotlin",
    -- Configuration
    "rasi",
    "toml",
    "yaml",
    -- Build
    "make",
    "nix",
    -- Go
    "go",
    "gomod",
    -- General
    "comment",
    "dart",
    "dockerfile",
    "haskell",
    "lua",
    "python",
    "ruby",
    "rust",
    "teal",
    "vim",
    "zig",
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
