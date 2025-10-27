{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.jj;
  tomlFormat = pkgs.formats.toml { };
  inherit (lib) mkOption mkIf types;
in
{
  options.terminal.jj = {
    enable = mkOption {
      description = "enable jj";
      type = types.bool;
      default = true;
    };

    settings = mkOption {
      type = tomlFormat.type;
      default = {
        user = {
          name = "Steven Sherry";
          email = "steven.r.sherry@gmail.com";
        };

        ui = {
          paginate = "auto";
          pager = "delta";
          diff-formatter = ":git";
          show-cryptographic-signatures = true;
          diff-editor = [
            "${pkgs.jjedit}/bin/jjedit"
            "-c"
            "DiffEditor $left $right $output"
          ];
        };

        signing = {
          behavior = "own";
          backend = "gpg";
          key = "5BE85414B74F99B1";
        };

        colors = {
          change_id = "bright yellow";
          rest = "default";
        };

        aliases = {
          ls = [
            "log"
            "-r"
            "::"
          ];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.jj ];
    xdg.configFile."jj/config.toml" = {
      source = tomlFormat.generate "jujutsu-config" cfg.settings;
    };
  };
}
