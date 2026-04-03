{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.emacs;
  inherit (lib) mkOption mkIf types;
in
{
  options.emacs = {
    enable = mkOption {
      description = "enable emacs";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
      client.enable = true;
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };
}
