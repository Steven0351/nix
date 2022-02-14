{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.openssh;
in
{
  options = {
    programs.openssh = {
      enable = mkOption {
        default = true;
        description = ''
          Whether to configure openssh. Enabling openssh through nix-darwin will disable the Apple openssh services. 
          The system openssh will need to manually be disabled via launchctl and new agent will have to be manually
          started via `launchctl kickstart system/dev.stevensherry.openssh.ssh-agent`.
        '';
        type = types.bool;
      };

      stdoutPath = mkOption {
        default = "~/.ssh/stdout.log";
        description = ''
          Path to store logging output for the ssh-agent.
          Defaults to ~/.ssh/stdout.log.
        '';
        type = types.str;
      };

      stderrPath = mkOption {
        default = "~/.ssh/stderr.log";
        description = ''
          Path to store stderr output for the ssh-agent.
          Defaults to ~/.ssh/stderr.log.
        '';
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.openssh ];
    launchd = {
      user.agents."dev.stevensherry.openssh.ssh-agent".serviceConfig = {
        ProgramArguments = [ "sh" "-c" "${pkgs.openssh}/bin/ssh-agent -D -a ~/.ssh/agent" ];
        EnableGlobbing = true;
        Label = "dev.stevensherry.openssh.ssh-agent";
        RunAtLoad = true;
        StandardOutPath = cfg.stdoutPath;
        StandardErrorPath = cfg.stderrPath;
      };
    };
  };
}
