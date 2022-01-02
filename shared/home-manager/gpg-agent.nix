{ pkgs, config, ...}: {
  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      no-grab 
      pinentry-program ${config.home.homeDirectory}/.nix-profile/bin/pinentry
    '';

    onChange = ''
      ./${config.home.homeDirectory}/.nix-profile/bin/gpgconf --kill gpg-agent
      ./${config.home.homeDirectory}/.nix-profile/bin/gpg-agent --daemon
    '';
  };
}
