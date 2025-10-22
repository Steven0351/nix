{ ... }: {
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        webpage.preferred_color_scheme = "dark";
      };
      fonts.hints = "bold 11pt Fira Code Nerd Font";
    };
  };
}
