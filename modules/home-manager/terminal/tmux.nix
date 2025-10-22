{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.terminal.tmux;
  kanagawaTmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "kanagawa-tmux";
    version = "0.1.0";
    rtpFilePath = "kanagawa.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "Steven0351";
      repo = "kanagawa-tmux";
      rev = "9ea1d3b5d309a486011a69a67f2aad208ce21197";
      sha256 = "sha256-GowKJPN4pMECCmrqQ4LD28F8hXZgkqtZA7wS0PC2hPc=";
    };
  };
  pluginModule =
    with lib;
    types.submodule {
      options = {
        plugin = mkPackageOption pkgs.tmuxPlugins "plugin" {
          example = "pkgs.tmuxPlugins.sensible";
          default = null;
          pkgsText = "pkgs.tmuxPlugins";
          extraDescription = "Path of the configuration file to include.";
        };

        extraConfig = mkOption {
          type = types.lines;
          description = "Additional configuration for the associated plugin";
          default = "";
        };
      };
    };
  inherit (lib) mkOption types;
in
{
  options.terminal.tmux = {
    enable = lib.mkOption {
      description = "enable tmux";
      type = lib.types.bool;
      default = true;
    };

    kanagawaFlavor = mkOption {
      default = "wave";
      type = types.enum [
        "dragon"
        "wave"
      ];
    };

    additionalPlugins = mkOption {
      default = [ ];
      type =
        with types;
        listOf (either package pluginModule)
        // {
          description = "list of additional plugin packages or submodules";
        };
    };
  };
  config = lib.mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;
        baseIndex = 1;
        keyMode = "vi";
        prefix = "C-M-S-a";
        terminal = "screen-256color";
        shell = "${pkgs.fish}/bin/fish";
        plugins =
          with pkgs.tmuxPlugins;
          [
            yank

            {
              plugin = fzf-tmux-url;
              extraConfig = ''
                set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
                set -g @fzf-url-history-limit '2000'
              '';
            }

            resurrect

            {

              plugin = continuum;
              extraConfig = ''
                set -g @continuum-restore 'on'
              '';
            }

            {
              plugin = kanagawaTmux;
              extraConfig = ''
                set -g @kanagawa_flavor ${cfg.kanagawaFlavor}

                set -g @kanagawa_directory_text " #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

                set -g @kanagawa_window_status_style "custom"
                set -gq @kanagawa_window_left_separator "#[fg=#{@thm_bg_alt},bg=default]"
                set -gq @kanagawa_window_right_separator "#[fg=#{@thm_bg_alt},bg=default]"
                set -gq @kanagawa_window_middle_separator ""
                set -gq @kanagawa_window_current_left_separator "#[fg=#{@thm_bg_alt},bg=default]"
                set -gq @kanagawa_window_current_right_separator "#[fg=#{@thm_light_purple},bg=default]"
                set -gq @kanagawa_window_current_middle_separator ""
                set -g @kanagawa_window_current_number ""
                set -g @kanagawa_window_current_number_color "#{E:@thm_light_purple}"
                set -g @kanagawa_window_current_text "#[fg=#{@thm_light_purple},bg=#{@thm_bg_alt}]#I#[fg=#{@thm_bg_alt},bg=#{@thm_light_purple}] #[fg=#{none},bg=#{@thm_light_purple}]#{?#{!=:#{window_name},}, #W,}"

                set -g @kanagawa_window_number ""
                set -g @kanagawa_window_number_color "#{E:@thm_bg_alt}"
                set -g @kanagawa_window_text "#[fg=#{@thm_fg},bg=#{@thm_bg_alt}] #I#{?#{!=:#{window_name},},  #W,}"

                set -g @kanagawa_window_number_position "right"
                set -g @kanagawa_window_flags "none"

                set -g @kanagawa_status_connect_separator "no"
                set -g @kanagawa_status_left_separator  " "
                set -g @kanagawa_status_right_separator " "

                set -g @kanagawa_directory_color "#{E:@thm_red}"
                set -g @kanagawa_uptime_color "#{E:@thm_teal}"

                set -g @kanagawa_status_background 'none'

                set -g status-left-length 100
                set -g status-left '#{E:@kanagawa_status_session}'

                # Right status
                set -g status-right-length 100
                set -g status-right '#{E:@kanagawa_status_directory}'
                set -ag status-right '#{E:@kanagawa_status_uptime}'
              '';
            }
          ]
          ++ cfg.additionalPlugins;

        extraConfig = ''
          set -g detach-on-destroy off
          set -g escape-time 0
          set -g history-limit 100000
          set -g renumber-windows on
          set -g set-clipboard on
          set -g focus-events on
          set -g status-keys emacs
          bind C-p previous-window
          bind C-n next-window
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R
          bind c kill-pane
          bind x swap-pane -D
          bind ^C new-window -c "#{pane_current_path}"
          bind ^D detach
          bind * list-clients
          bind | split-window
          bind s split-window -v -c "#{pane_current_path}"
          bind v split-window -h -c "#{pane_current_path}"
          bind -r -T prefix , resize-pane -L 20
          bind -r -T prefix . resize-pane -R 20
          bind -r -T prefix - resize-pane -D 7
          bind -r -T prefix = resize-pane -U 7
          bind '"' choose-window

          bind-key "T" run-shell "sesh connect \"$(
            sesh list --icons | fzf --tmux 80%,70% \
              --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
              --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
              --bind 'tab:down,btab:up' \
              --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
              --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list --icons -t)' \
              --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list --icons -c)' \
              --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list --icons -z)' \
              --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
              --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
              --preview-window 'right:55%' \
              --preview 'sesh preview {}' \
              -- --ansi
          )\""

          set -g status-position top
          set -g status 2
          set -g status-format[1] ""
        '';
      };

      # We "disable" tmux integration because it requries that
      # fzf have tmux integration enabled. However, there are
      # issues with command line history with ctrl-r when FZF_TMUX
      # tmux is enabled.
      sesh = {
        enable = true;
        enableTmuxIntegration = false;
      };
    };
  };
}
