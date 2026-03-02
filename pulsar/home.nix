{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/linux/hyprland
  ];

  terminal = {
    enable = true;
    ghostty.enable = false;

    tmux.kanagawaFlavor = "conifer";

    kitty = {
      enable = true;
      themeFile = "conifer";
      font = {
        name = "TX-02 Thin";
        size = 12;
      };
    };
  };

  hyprland.enable = true;
  wallpapers.enable = true;

  home.packages = with pkgs; [
    _1password-gui
    _1password-cli
    stevenvim
    nerd-fonts.jetbrains-mono
    mpv
    qmk
    qutebrowser
    vivaldi
    firefox
    discord
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables.EDITOR = "stevenvim";
  home.stateVersion = "25.05";
}
