{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    #   cat /Users/stevensherry/.nix-profile/etc/profile.d/nix.sh | /Users/stevensherry/.nix-profile/bin/babelfish | source
    # '';
    shellAliases = {
      ls = "exa -G --color auto --icons -a -s type";
      ll = "exa -l --color always --icons -a -s type";
      cat = "bat";
    };

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
