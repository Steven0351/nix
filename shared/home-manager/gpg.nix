{ ... }: {
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      reader-port = "'Yubico YubiKey OTP+FIDO+CCID'";
    };
  };
}
