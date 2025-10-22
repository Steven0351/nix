{ lib, config, ... }:
let
  cfg = config.terminal.fzf;
  inherit (lib) mkOption types mkIf;
in
{
  options.terminal.fzf = {
    enable = mkOption {
      description = "enable fzf";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.terminal.fish.enable;
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview"
        "'bat -n --color always {}'"
      ];
    };

    programs.fd.enable = true;
  };
}
