{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/linux/hyprland
  ];

  terminal = {
    enable = true;
    ghostty.enable = false;
    kitty.enable = true;
  };

  hyprland.enable = true;
  wallpapers.enable = true;

  home.packages = with pkgs; [ stevenvim ];
  home.sessionVariables.EDITOR = "stevenvim";
  home.stateVersion = "25.05";
}
