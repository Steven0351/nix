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
    qmk
    xcbeautify
    yubikey-manager
    aspell
  ];

  home.stateVersion = "22.05";

  terminal = {
    enable = true;
    tmux.kanagawaFlavor = "dragon";
  };

  wallpapers.enable = true;

  programs.sketchybar = {
    enable = true;

    extraPackages = with pkgs; [
      yabai
      jq
    ];

    config = {
      source = ./config/sketchybar;
      recursive = true;
    };

    includeSystemPath = true;
    service.enable = true;
  };
}
