{ config, ...}: {
  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      enable-ssh-support
      pinentry-program ${config.home.homeDirectory}/.nix-profile/bin/pinentry-mac
    '';

    onChange = ''
      ${config.home.homeDirectory}/.nix-profile/bin/gpg-connect-agent reloadagent /bye
    '';
  };
}
