{ pkgs, ... }:
{
  terminal = {
    enable = true;
    kitty.enable = false;
    git.overrides = {
      settings.user.email = "steven.sherry@abbyy.com";
    };
  };

  home.packages = with pkgs; [
    stevenvim
    socat
  ];

  home.stateVersion = "25.05";
  home.sessionVariables.WIN_HOME = "/mnt/c/Users/Steven.Sherry";
  home.sessionVariables.EDITOR = "stevenvim";
}
