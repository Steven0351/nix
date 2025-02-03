{ config, ... }: {
  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      grab
      pinentry-program ${config.home.homeDirectory}/.nix-profile/bin/pinentry
    '';

    onChange = ''
      gpgconf --kill gpg-agent
      gpg-agent --daemon
    '';
  };
}
