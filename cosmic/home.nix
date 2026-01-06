{ pkgs, ... }:
let
  aspell = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
    d.en-science
  ]);
in
{
  home.packages = with pkgs; [
    aerc
    cmake
    glibtool
    weechat
    diffnav
    qmk
    nerdfont-search
    xcbeautify
    yubikey-manager
    aspell
    terminal-notifier
  ];

  home.stateVersion = "22.05";
  home.sessionVariables.EDITOR = "stevenvim";

  terminal = {
    enable = true;
    tmux.kanagawaFlavor = "conifer";
    kitty.themeFile = "conifer";
    kitty.font = {
      name = "TX-02-Kitty";
      size = 16;
    };
  };

  wallpapers.enable = true;
}
