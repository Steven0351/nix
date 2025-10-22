{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.gh;
  inherit (lib) mkOption mkIf types;
  myGh =
    with pkgs;
    writeShellApplication {
      name = "gh";
      runtimeInputs = [
        _1password-cli
        gh
      ];
      text = ''
        op plugin run -- gh "$@"
      '';
    };
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.terminal.gh = {
    enable = mkOption {
      description = "enable gh";
      type = types.bool;
      default = true;
    };

    settings = mkOption {
      type = yamlFormat.type;
      default = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ myGh ];
    xdg.configFile."gh/config.yml".source = yamlFormat.generate "gh-config.yml" (
      { version = "1"; } // cfg.settings
    );
  };
}
