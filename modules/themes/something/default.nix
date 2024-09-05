{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.file = {
      ".config/assets/wallpapers".source = ./wallpapers;
      ".config/hypr/theme.conf".text = ''
        exec-once = hyprctl setcursor Bibata-Modern-Classic 24

        general {
        	gaps_in = 5
        	gaps_out = 10
        	border_size = 2

        	col.active_border = rgb(E0E1DD) rgb(778DA9) 45deg
        	col.inactive_border = rgb(0D1B2A) rgb(1B263B) 45deg
        }

        decoration {
        	rounding = 2
        	
        	drop_shadow = yes
        	
        	shadow_range = 4
        	shadow_render_power = 3
        	col.shadow = rgba(1a1a1aee)

        	active_opacity = 0.9
        	inactive_opacity = 0.75
        	fullscreen_opacity = 0.9
        	
        	blur {
        		enabled = yes
        		size = 8
        		passes = 3
        		new_optimizations = true
        		xray = true
        	}
        }

        animations {
        	enabled = yes
        	
        	bezier = easeOutQuad, 0.5, 1.0, 0.89, 1.0
        	
        	animation = windows, 1, 7, easeOutQuad
        	animation = windowsOut, 1, 7, easeOutQuad, popin 85%
        	animation = border, 1, 10, easeOutQuad
        	animation = borderangle, 1, 8, easeOutQuad
        	animation = fade, 1, 7, easeOutQuad
        	animation = workspaces, 1, 6, easeOutQuad
        }
      '';
    };

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

