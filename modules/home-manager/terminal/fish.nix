{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.terminal.fish;
in
{

  options.terminal.fish = {
    enable = lib.mkOption {
      description = "enable fish";
      type = lib.types.bool;
      default = true;
    };

    additionalAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Additional aliases or overrides";
    };

    appendShellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Addtional fish config to include";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        ls = "eza -G --color auto --icons -a -s type";
        ll = "eza -l --color always --icons -a -s type";
        tree = "eza --tree --icons";
        cat = "bat";
      }
      // cfg.additionalAliases;

      shellInit = ''
        set -x GPG_TTY (tty)
        set -l foreground c5c9c5 normal
        set -l selection 2D4F67 brcyan
        set -l comment a6a69c brblack
        set -l red c4746e red
        set -l orange b6927b brred
        set -l yellow c4b28a yellow
        set -l green 8a9a7b green
        set -l purple 8992a7 magenta
        set -l cyan 8ea4a2 cyan
        set -l pink a292a3 brmagenta

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set fish_color_cancel \x2dr
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_history_current \x2d\x2dbold
        set fish_color_host normal
        set fish_color_host_remote yellow
        set fish_color_match \x2d\x2dbackground\x3dbrblue
        set fish_color_status red
        set fish_color_user brgreen
        set fish_color_valid_path \x2d\x2dunderline

        set SHELL (which fish)
      ''
      + lib.optionalString pkgs.stdenv.isDarwin ''
        set -x SSH_AUTH_SOCK ~/.ssh/agent
        set -x ZK_NOTEBOOK_DIR ~/notes
        fish_add_path ~/.local/bin
      ''
      + cfg.appendShellInit;

      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          };
        }
      ];

      functions = {
        xcode = lib.optionalString pkgs.stdenv.isDarwin ''
          set -l xversion $argv[1]
          set -l command_length (count $argv)
          env DEVELOPER_DIR=/Applications/Xcode-$xversion.app/Contents/Developer $argv[2..$command_length]
        '';
      };
    };
  };
}
