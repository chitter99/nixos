{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = {
    programs.fish = {
      enable = true;
      shellInit = ''
        direnv hook fish | source

        # Here would be the place for op/plugin.sh
        set -g fish_greeting

        # use 1password ssh-agent
        set -Ux SSH_AUTH_SOCK ~/.1password/agent.sock
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      nitch # So it looks cool :3
    '';
  };
}
