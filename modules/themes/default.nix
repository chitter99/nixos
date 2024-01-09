{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Tela";
        package = pkgs.tela-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
      theme = {
        name = "Graphite-Dark";
        package = pkgs.graphite-gtk-theme;  
      };

      #iconTheme = {
      #  name = "WhiteSur-dark";
      #  package = pkgs.whitesur-icon-theme;
      #};
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        # We have to set stuff here, see https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
           
        gtk-theme = "Graphite-Dark";
        icon-theme = "Tela";
        cursor-theme = "Bibata-Modern-Classic";

        ## Font stuff
        #font-name = "xy";
        #monospace-font-name = "RobotoMono Nerd Font 10";
        #font-antialiasing = "rgba";
      };
    };
  };
}

