{ pkgs, home-manager, username, ... }:
{
  programs.dconf.enable = true;

  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      nautilus
      zenity
      gnome-tweaks
      eog
      gnome-disk-utility
      gedit
    ];
  };
}
