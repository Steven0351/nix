{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.gpg;
  inherit (lib) mkOption mkIf types;
in
{
  options.terminal.gpg = {
    enable = mkOption {
      description = "enable gpg";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = ./me.gpg.pub;
          trust = "ultimate";
        }
      ];
      scdaemonSettings = {
        disable-ccid = true;
        reader-port = "Yubico Yubi";
      };
    };

    home.file.".gnupg/gpg-agent.conf" =
      with pkgs;
      mkIf stdenv.isDarwin {
        text = ''
          enable-ssh-support
          pinentry-program ${pinentry_mac}/bin/pinentry-mac
        '';

        onChange = ''
          ${gnupg}/bin/gpg-connect-agent reloadagent /bye
        '';
      };

    services.gpg-agent =
      with pkgs;
      mkIf stdenv.isLinux {
        enable = true;
        enableExtraSocket = true;
        defaultCacheTtl = 3600;
        pinentry.package = pkgs.pinentry-curses;
      };
  };

}
