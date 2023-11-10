{ stdenv
, fetchFromGitHub
, writeShellScriptBin
, writeText
, git
, neovim
, fd
, ripgrep
}:

let
  lazyNvimSrc = stdenv.mkDerivation {
    name = "lazy.nvim";
    branch = "stable";

    patches = [ ./help.patch ];

    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "3ad55ae678876516156cca2f361c51f7952a924b";
      sha256 = "L8x23jox8fLZTt17sDG21N2sqsSdmtLeUUp0h2Py7fs=";
    };

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/lazy.nvim
      cp -r . $out/lazy.nvim
    '';
  };

  lazyInit = writeText "init.lua" ''
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim with existing clone
    lazypath = "${lazyNvimSrc}/lazy.nvim"
  end
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath);
  -- vim.opt.rtp:prepend(vim.env.LAZY_CONFIG or vim.fn.stdpath("config") .. "/lazyvim");

  local spec = {
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      { import = "plugins" }
  }

  local lazycore_ok, lazycore = pcall(require, "lazycore")
  if lazycore_ok then
    vim.list_extend(spec, lazycore.imports)
  end

  -- do something here to conditionally get a lazy config table and merge it with these defaults
  require("lazy").setup({
    spec = spec,
    defaults = {
      lazy = false,
      version = false,
    },
    help = {
      root = "/Users/steven0351/.config/help"
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
  '';
in

writeShellScriptBin "lazyvim" ''
  export NVIM_APPNAME=lazyvim
  export PATH=${neovim}/bin:${fd}/bin:${ripgrep}/bin:${git}/bin:$PATH
  exec -a lazyvim nvim -u ${lazyInit} $@
''
