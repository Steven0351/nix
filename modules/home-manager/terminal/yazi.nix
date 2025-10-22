{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.yazi;
  inherit (lib) mkIf mkOption types;
  kanagawaYazi = pkgs.yaziPlugins.mkYaziPlugin {
    pname = "kanagawa.yazi";
    version = "0-unstable-2025-10-24";

    src = pkgs.fetchFromGitHub {
      owner = "dangooddd";
      repo = "kanagawa.yazi";
      rev = "a0b1d9dec31387b5f8a82c96044e6419b6c46534";
      hash = "sha256-nGFiAgVWfq7RkuGGCt07zm3z7ZTGiIPIR319ojPfdUk=";
    };
  };
in
{
  options.terminal.yazi = {
    enable = mkOption {
      description = "enable yazi";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      flavors = {
        kanagawa = kanagawaYazi;
      };

      settings = {
        show_hidden = true;
      };

      theme = {
        flavor = {
          dark = "kanagawa";
        };

        status = {
          sep_left = {
            open = "";
            close = "";
          };

          sep_right = {
            open = "";
            close = "";
          };
        };
      };
    };
  };
}
