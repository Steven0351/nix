{ lib, config, ... }:
let
  cfg = config.terminal.starship;
  inherit (lib) mkOption mkIf types;
in
{
  options.terminal.starship = {
    enable = mkOption {
      description = "enable starship";
      type = types.bool;
      default = true;
    };

    overrides = mkOption {
      description = "settings override";
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = config.terminal.fish.enable;
      settings = {
        command_timeout = 5000;

        character = {
          success_symbol = "[ ](bold green)";
          error_symbol = "[ ](bold red)";
        };

        directory = {
          read_only = "  ";
        };

        git_branch = {
          only_attached = true;
        };

        git_commit = {
          tag_disabled = false;
          tag_symbol = "  ";
          format = "[on](fg:white) [ $hash](bold fg:purple)[$tag](fg:blue) ";
        };

        git_status = {
          format = "([$conflicted$stashed$deleted$modified$staged$untracked$ahead_behind]($style))";
          conflicted = "[ $count](bold fg:red)]";
          staged = "[ $count ](fg:green)";
          modified = "[󰙏 $count ](fg:yellow)";
          deleted = "[ $count ](fg:red)";
          untracked = "[ $count ](fg:#D08770)";
          stashed = "[  $count ](fg:blue)";
          ahead = "[ $count ](fg:white)";
          behind = "[ $count ](fg:white)";
        };

        hostname = {
          ssh_symbol = "󱄄 ";
        };

        package = {
          symbol = " ";
        };

        c = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
          style = "bold purple";
        };

        elm = {
          symbol = " ";
          style = "bold blue";
        };

        erlang = {
          symbol = " ";
          style = "bold red";
        };

        gcloud = {
          disabled = true;
        };

        golang = {
          symbol = "󰟓 ";
        };

        java = {
          symbol = " ";
          style = "bold red";
        };

        kotlin = {
          symbol = " ";
        };

        nix_shell = {
          symbol = "󱄅 ";
        };

        purescript = {
          symbol = " ";
        };

        python = {
          symbol = " ";
          style = "bold yellow";
        };

        ruby = {
          symbol = " ";
          style = "bold red";
        };

        rust = {
          symbol = " ";
          style = "bold red";
        };

        swift = {
          symbol = " ";
          style = "bold #D08770";
        };

        terraform = {
          symbol = "󱁢 ";
        };

        zig = {
          symbol = " ";
        };
      }
      // cfg.overrides;
    };
  };

}
