{ ... }: {
  xdg.configFile.nvim = {
    source = ../nvim;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };
}
