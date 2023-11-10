{ pkgs, ... }: {
  programs.exa.enable = true;
  programs.exa.package = pkgs.eza;
  # Makes directories not bold. There are icons, who cares.
  home.sessionVariables.EXA_COLORS = "di=34";
}
