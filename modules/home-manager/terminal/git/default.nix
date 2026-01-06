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
        email = "mail@stevensherry.dev";
      };

      ignores = [
        ".DS_Store"
        ".direnv"
        ".envrc"
        ".idea"
        ".nvim.lua"
        ".rgignore"
        ".tmux.session"
        "*.bk"
        "*.log"
        "*.old"
        ".claude/settings.local.json"
        "tmp/"
        "tags"
      ];

      includes = [
        { path = ./kanagawa.gitconfig; }
      ];

      signing = {
        key = "BCDD4DA011238CC5";
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
