{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/linux/hyprland
  ];

  terminal = {
    enable = true;
    ghostty.enable = false;
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 14;
      };
    };
  };

  hyprland.enable = true;
  wallpapers.enable = true;

  home.packages = with pkgs; [
    stevenvim
    nerd-fonts.jetbrains-mono
    qutebrowser
    vivaldi
    firefox
    discord
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables.EDITOR = "stevenvim";
  home.stateVersion = "25.05";
}
