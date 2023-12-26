{pkgs, home-manager, username, ... }:
{
  #imports = [ (import ./dots {inherit home-manager username;}) ];
  
  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.fish = {
      enable = true;
      shellInit = ''
direnv hook fish | source

# Here would be the place for op/plugin.sh
set -g fish_greeting

# start ssh-agent
#if test -z "(pgrep ssh-agent)"
#  eval (ssh-agent -c)
#  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#end

# use 1password ssh-agent
set -Ux SSH_AUTH_SOCK ~/.1password/agent.sock
      '';
    };
  };

  # ---- System Configuration ---- #
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
