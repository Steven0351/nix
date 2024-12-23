{ ... }: {
  xdg.configFile."lvim" = {
    source = ./config;
    recursive = true;
  };
}
