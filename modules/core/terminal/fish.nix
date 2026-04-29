{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = {
    programs.bash = { enable = true; };

    programs.fish = {
      enable = true;
      shellInit = ''
        direnv hook fish | source

        set -g fish_greeting
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
