{ mango, ... }@inputs:
{ pkgs, ... }:
{
  imports = [
    mango.hmModules.mango
    ../modules/home-manager/linux/desktop
    ../modules/home-manager/linux/mango
    ../modules/home-manager/linux/hyprland
  ];

  emacs.enable = true;

  terminal = {
    enable = true;

    ghostty = {
      overrides = {
        font-family = [
          "TX-02"
          "Symbols Nerd Font Mono"
        ];
      };
    };

    gh.enable = false;

    tmux.kanagawaFlavor = "conifer";

    kitty = {
      enable = true;
      themeFile = "conifer";
      font = null;
      extraConfig = ''
        font_family family=TX-02 style=Light
        font_size 16.0
      '';
    };
  };

  mango.enable = true;
  hyprland.enable = false;
  wallpapers.enable = true;

  home.packages = with pkgs; [
    aerc
    hut
    mpv

    nerd-fonts.jetbrains-mono
    julia-mono
    google-fonts

    picotool
    qmk

    stevenvim

    qutebrowser
    vivaldi
    firefox
    brave

    discord
    signal-desktop
    teams-for-linux

    wiremix

    remmina

    gradia
    swappy
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-key-theme = "Emacs";
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      hyprland.default = [
        "wlr"
        "gtk"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables.EDITOR = "stevenvim";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/guix/current/bin"
  ];
  home.stateVersion = "25.05";
}
