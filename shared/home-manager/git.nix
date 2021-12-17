{ pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Steven Sherry";
    userEmail = "steven.sherry@affinityforapps.com";

    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
        line-numbers = true;
      };
    };

    ignores = [".DS_Store"];

    signing = {
      key = "5BE85414B74F99B1";
      signByDefault = true;
    };
  };
}
