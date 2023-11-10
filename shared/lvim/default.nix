{ stdenv
, fetchFromGitHub
, writeShellScriptBin
, git
, neovim
, fd
, ripgrep
, dataHome
, configHome
, cacheHome
}:

let 
  lvimSrc = stdenv.mkDerivation {
    name = "lvim";

    src = fetchFromGitHub {
      owner = "LunarVim";
      repo = "LunarVim";
      rev = "15dc5292922b8b6009db645225bfee1f26796a68";
      sha256 = "sha256-4j17K7TCa9JF52T8s+iK6ftcuv00H2GtPlXEDNXgVWE=";
    };

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/lvim
      cp -r . $out/lvim
    '';
  };
in

writeShellScriptBin "lvim" ''
  export NVIM_APPNAME="lvim"
  export LUNARVIM_RUNTIME_DIR=${dataHome}/lunarvim
  export LUNARVIM_CONFIG_DIR=${configHome}/lvim
  export LUNARVIM_CACHE_DIR=${cacheHome}/lvim
  export LUNARVIM_BASE_DIR=${lvimSrc}/lvim
  export PATH=${neovim}/bin:${ripgrep}/bin:${fd}/bin:${git}/bin:/usr/bin:$PATH
  exec -a $NVIM_APPNAME nvim -u $LUNARVIM_BASE_DIR/init.lua $@
''

