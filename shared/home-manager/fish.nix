{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "exa -G --color auto --icons -a -s type";
      ll = "exa -l --color always --icons -a -s type";
      cat = "bat";
    };

    shellInit = ''
      set GPG_TTY (tty)
    '';

    plugins = [{
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
      };
    }];
  };
}
