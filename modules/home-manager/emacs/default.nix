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

    enableDoom = mkOption {
      description = "set environment variables for doom emacs";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = e: [
        e.base16-theme
	e.change-inner
	e.direnv
        e.dirvish
        e.doom-themes
        e.company
        e.consult
        e.embark
	e.expand-region
	e.font-utils
	e.ligature
        e.magit
        e.marginalia
	e.nerd-icons
        e.no-littering
        e.nix-ts-mode
        e.orderless
	e.pcache
	e.persp-mode
	e.popwin
	e.projectile
        e.treesit-grammars.with-all-grammars
	e.ucs-utils
	e.unicode-fonts
        e.vertico
        e.vterm
      ];
    };

    xdg.configFile."emacs/early-init.el".source = ./emacs/early-init.el;
    xdg.configFile."emacs/init.el".source = ./emacs/init.el;

    home.sessionVariables = {
      # This is just in case I need to fall back for reasons
      DOOMDIR = lib.optionalString cfg.enableDoom "${config.xdg.configHome}/doom";
    };
  };
}
