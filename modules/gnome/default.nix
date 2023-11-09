{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs.gnome; [
      nautilus
      zenity
      gnome-tweaks
      eog
      gedit
      gnome-disk-utility
    ]; 
  };
}
