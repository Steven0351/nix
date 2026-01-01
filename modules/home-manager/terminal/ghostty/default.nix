{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.ghostty;
  inherit (lib) mkOption mkIf types;
  keyValueSettings = {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
  };
  keyValue = pkgs.formats.keyValue keyValueSettings;
in
{
  options.terminal.ghostty = {
    enable = mkOption {
      description = "enable ghostty";
      type = types.bool;
      default = true;
    };

    overrides = lib.mkOption {
      inherit (keyValue) type;
      default = { };
      example = lib.literalExpression ''
        {
          theme = "catppuccin-mocha";
          font-size = 10;
          keybind = [
            "ctrl+h=goto_split:left"
            "ctrl+l=goto_split:right"
          ];
        }
      '';
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/ghostty/config`.

        See <https://ghostty.org/docs/config/reference> for more information.
      '';
    };

  };

  config = mkIf cfg.enable {
    programs.ghostty.enable = true;
    programs.ghostty.package = null;
    programs.ghostty.enableFishIntegration = true;

    programs.ghostty.settings = {
      command = "${pkgs.fish}/bin/fish";
      theme = "conifer";
      font-family = [
        "TX-02-Ghostty"
        "Symbols Nerd Font Mono"
      ];
      font-size = 16;
      font-style = "Light";
      font-style-italic = "Light Oblique";
      font-style-bold = "Bold";
      font-style-bold-italic = "Bold Oblique";
      window-padding-x = 16;
      window-padding-y = "16,8";
      macos-titlebar-style = "hidden";
      keybind = [
        "cmd+w=close_surface"
        "cmd+shift+w=close_window"
        "global:cmd+shift+enter=toggle_quick_terminal"
        "cmd+shift+i=inspector:toggle"
      ];
      clipboard-read = "allow";
      clipboard-write = "allow";
      custom-shader = "${./shaders/cursor_warp.glsl}";
      shell-integration-features = "no-cursor";
    }
    // cfg.overrides;

    xdg.configFile."ghostty/themes" = {
      source = ./themes;
      recursive = true;
    };
  };
}
