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
  lvimSrc = stdenv.mkDerivation rec {
    pname = "lvim";
    version = "1.2.0";

    src = fetchFromGitHub {
      owner = "LunarVim";
      repo = "LunarVim";
      rev = version;
      sha256 = "xlQ4qOUG1+wXyr1xVO2Mni/L3bKyrIlPFmve5w2Xoss=";
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
  export LUNARVIM_RUNTIME_DIR=${dataHome}/lunarvim
  export LUNARVIM_CONFIG_DIR=${configHome}/lvim
  export LUNARVIM_CACHE_DIR=${cacheHome}/lvim
  export LUNARVIM_BASE_DIR=${lvimSrc}/lvim
  export PATH=${neovim}/bin:${ripgrep}/bin:${fd}/bin:${git}/bin:/usr/bin:$PATH
  exec -a lvim nvim -u $LUNARVIM_BASE_DIR/init.lua $@
''

