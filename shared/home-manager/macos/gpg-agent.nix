{ pkgs, config, ...}: {
  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      pinentry-program ${config.home.homeDirectory}/.nix-profile/bin/pinentry-curses
    '';

    onChange = ''
      ${config.home.homeDirectory}/.nix-profile/bin/gpg-connect-agent reloadagent /bye
    '';
  };
}
