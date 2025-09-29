{ ... }:
{
  programs.bat = {
    config = {
      theme = "kanagawa";
    };
    themes = {
      kanagawa = {
        src = ./themes;
        file = "kanagawa.tmTheme";
      };
    };
    enable = true;
  };

  # home.file.".config/bat/themes/kanagawa.tmTheme".source = ./kanagawa.tmTheme;
}
