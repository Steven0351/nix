{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/linux/desktop
    ../modules/home-manager/linux/sway
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

  sway.enable = true;
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
    vis

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

    unzip
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
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config.common = {
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };
    
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables.EDITOR = "stevenvim";
  
  home.sessionVariables.TERMCMD = "kitty --class=file_chooser";
  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text =
      ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
  };
  
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/guix/current/bin"
  ];
  
  home.stateVersion = "25.05";
}
