{ ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    pinentryFlavor = "curses";
  };
}
