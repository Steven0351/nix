{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza -G --color auto --icons -a -s type";
      ll = "eza -l --color always --icons -a -s type";
      tree = "eza --tree --icons";
      cat = "bat";
    };

    shellInit = ''
      set -x GPG_TTY (tty)
      set fish_color_autosuggestion 4c566a
      set fish_color_cancel \x2dr
      set fish_color_command 81a1c1
      set fish_color_comment 434c5e
      set fish_color_cwd green
      set fish_color_cwd_root red
      set fish_color_end 88c0d0
      set fish_color_error ebcb8b
      set fish_color_escape 00a6b2
      set fish_color_history_current \x2d\x2dbold
      set fish_color_host normal
      set fish_color_host_remote yellow
      set fish_color_match \x2d\x2dbackground\x3dbrblue
      set fish_color_normal normal
      set fish_color_operator 00a6b2
      set fish_color_param eceff4
      set fish_color_quote a3be8c
      set fish_color_redirection b48ead
      set fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
      set fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
      set fish_color_status red
      set fish_color_user brgreen
      set fish_color_valid_path \x2d\x2dunderline
      set fish_pager_color_completion normal
      set fish_pager_color_description B3A06D\x1eyellow
      set fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
      set fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

      set SHELL (which fish)
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      set -x SSH_AUTH_SOCK ~/.ssh/agent
      set -x ZK_NOTEBOOK_DIR ~/notes
    '';

    plugins = [{
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
      };
    }];

    functions = {
      xcode = lib.optionalString pkgs.stdenv.isDarwin ''
        set -l xversion $argv[1]
        set -l command_length (count $argv)
        env DEVELOPER_DIR=/Applications/Xcode-$xversion.app/Contents/Developer $argv[2..$command_length]
      '';
    };
  };
}
