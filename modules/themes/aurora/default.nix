{ pkgs, lib, home-manager, username, ... }:
{
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/assets/wallpapers".source = ./wallpapers;
      ".config/hypr/theme.conf".source = ./dots/hypr/theme.conf;
      ".config/waybar/config.jsonc".source = lib.mkForce ./dots/waybar/config.jsonc;
      ".config/waybar/style.css".source = lib.mkForce ./dots/waybar/style.css;
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
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Graphite-Dark";
        icon-theme = "Tela";
        cursor-theme = "Bibata-Modern-Classic";
      };
    };
  };
}

