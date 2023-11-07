{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    packages = with pkgs.gnome; [
      nautilus
      zenity
      gnome-tweaks
      eog
      gedit
    ]; 
  };
}
