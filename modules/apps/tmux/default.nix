{ username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
        {
          plugin = tmux-super-fingers;
          extraConfig = "set -g @super-fingers-key f";
        }
        tmuxPlugins.better-mouse-mode
      ];
      extraConfig = ''
        # 
        set-option -g mouse on
      '';
    };
  };
}
