{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.desktop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.desktop = {
    enable = mkEnableOption "wayland desktop necessities";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6Packages.qt6ct
      awww
      dunst
      libnotify
      swappy
      vicinae
      wl-clipboard
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";

      GDK_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    xresources.properties = {
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintfull";
      "Xft.antialias" = "rgba";
      "Xft.rgba" = "rgb";
    };
  };
}
