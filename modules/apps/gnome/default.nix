{ pkgs, home-manager, username, ... }:
{
  programs.dconf.enable = true;

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
