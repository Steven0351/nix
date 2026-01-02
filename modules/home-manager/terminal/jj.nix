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
          email = "mail@stevensherry.dev";
        };

        ui = {
          paginate = "auto";
          pager = "delta";
          diff-formatter = [
            "difft"
            "--color=always"
            "$left"
            "$right"
          ];
          show-cryptographic-signatures = true;
          merge-editor = "diffconflicts";
          diff-editor = [
            "${pkgs.jjedit}/bin/jjedit"
            "-c"
            "DiffEditor $left $right $output"
          ];
        };

        merge-tools = {
          diffconflicts = {
            program = "stevenvim";
            merge-args = [
              "-c"
              "let g:jj_diffconflicts_marker_length=$marker_length"
              "-c"
              "JJDiffConflicts!"
              "$output"
              "$base"
              "$left"
              "$right"
            ];
            merge-tool-edits-conflict-markers = true;
          };
        };

        signing = {
          behavior = "own";
          backend = "gpg";
          key = "BCDD4DA011238CC5";
        };

        colors = {
          bookmarks = {
            bold = true;
          };
        };

        aliases = {
          ls = [
            "log"
            "-r"
            "::"
          ];

          pb = [
            "git"
            "push"
            "--bookmark"
          ];

          pc = [
            "git"
            "push"
            "--change"
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
