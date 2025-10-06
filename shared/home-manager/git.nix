{
  overrides ? { },
}:
{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings.user = {
      name = "Steven Sherry";
      email = "steven.r.sherry@gmail.com";
    };

    ignores = [
      ".DS_Store"
      ".direnv"
      ".lazyconf"
      ".lazy.lua"
      ".idea"
      "tmp/"
      ".envrc"
      ".direnv"
      ".nvim.lua"
      ".log"
    ];

    includes = [
      { path = ./kanagawa.gitconfig; }
    ];

    signing = {
      key = "5BE85414B74F99B1";
      signByDefault = true;
    };
  }
  // overrides;

  programs.delta = {
    enable = true;
    options = {
      features = "kanagawa-wave";
      syntax-theme = "kanagawa";
      line-numbers = true;
    };
  };

}
