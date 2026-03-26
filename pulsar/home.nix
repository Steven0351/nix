{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/linux/hyprland
  ];

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

  hyprland.enable = true;
  wallpapers.enable = true;

  home.packages = with pkgs; [
    stevenvim
    nerd-fonts.jetbrains-mono
    mpv
    qmk
    picotool
    qutebrowser
    vivaldi
    firefox
    discord
    signal-desktop
    wiremix
    remmina
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
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
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.stateVersion = "25.05";
}
