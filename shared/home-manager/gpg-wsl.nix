{ ... }: {
  programs.gpg = {
    enable = true;
    publicKeys = [{
      source = ./me.gpg.pub;
      trust = "ultimate";
    }];
    scdaemonSettings = {
      disable-ccid = true;
      reader-port = "Yubico.com Yubikey 4/5 OTP+U2F+CCID";
    };
  };
}
