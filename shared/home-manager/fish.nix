{ pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    cat /Users/stevensherry/.nix-profile/etc/profile.d/nix.sh | /Users/stevensherry/.nix-profile/bin/babelfish | source
    direnv hook fish | source
    '';
    shellAliases = {
      ls = "exa -G --color auto --icons -a -s type";
      ll = "exa -l --color always --icons -a -s type";
    };
  };
}
