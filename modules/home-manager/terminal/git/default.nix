{ lib, config, ... }:
let
  cfg = config.terminal.git;
in
{
  options.terminal.git = {
    enable = lib.mkOption {
      description = "enable git";
      type = lib.types.bool;
      default = true;
    };

    overrides = lib.mkOption {
      description = "Any overrides to the defaults";
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings.user = {
        name = "Steven Sherry";
        email = "steven.r.sherry@gmail.com";
      };

      ignores = [
        ".DS_Store"
        ".direnv"
        ".lazyconf"
        ".lazy.lua"
        ".idea"
        "tmp/"
        ".envrc"
        ".direnv"
        ".nvim.lua"
        ".log"
        "tags"
      ];

      includes = [
        { path = ./kanagawa.gitconfig; }
      ];

      signing = {
        key = "5BE85414B74F99B1";
        signByDefault = true;
      };
    }
    // cfg.overrides;

    programs.delta = {
      enable = true;
      options = {
        features = "kanagawa-wave";
        syntax-theme = "kanagawa";
        line-numbers = true;
      };
    };
  };

}
