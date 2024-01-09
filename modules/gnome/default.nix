{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs.gnome; [
      nautilus
      zenity
      gnome-tweaks
      eog
      gnome-disk-utility
    ]
    ++ [
      pkgs.gedit      
    ]; 
  };
}
