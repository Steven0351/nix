{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    defaultCacheTtl = 3600;
    pinentry.package = pkgs.pinentry-curses;
  };
}
