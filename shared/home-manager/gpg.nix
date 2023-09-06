{ ... }: {
  programs.gpg = {
    enable = true;
    publicKeys = [{
      source = ./me.gpg.pub;
      trust = "ultimate";
    }];
    scdaemonSettings = {
      disable-ccid = true;
      reader-port = "Yubico Yubi";
      # reader-port = "'Yubico YubiKey OTP+FIDO+CCID'";
    };
  };
}
