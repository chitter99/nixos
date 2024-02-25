{ pkgs, home-manager, username, ... }:

let
  rcloneMountArgs = ''
  --vfs-cache-mode full \
  --dir-cache-time 48h \
  --vfs-cache-max-age 48h \
  --vfs-read-chunk-size 10M \
  --vfs-read-chunk-size-limit 512M \
  --buffer-size 512M
  '';
  mountOneDrive = "/home/${username}/onedrive";
in 
{
  #----- Home Manager Config -----
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
        openfortivpn
    ];
  };
}
