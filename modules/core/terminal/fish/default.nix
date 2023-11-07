{pkgs, home-manager, username, ... }:
{
  #imports = [ (import ./dots {inherit home-manager username;}) ];
  
  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.fish = {
      enable = true;
    };
    home.file = {
      ".config/fish/config.fish" = ''
starship init fish | source
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
