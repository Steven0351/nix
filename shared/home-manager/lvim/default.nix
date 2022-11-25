{ ... }: {
  xdg.configFile."lvim" = {
    source = ./config;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "lvim";
    MANPAGER = "lvim +Man!";
  };
}
