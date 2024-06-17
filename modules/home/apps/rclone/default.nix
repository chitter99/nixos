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
      rclone
      fuse
     ];

    systemd.user.services.rclone-onedrive = {
      Unit = {
        Description = "mount onedrive dir";
        After = [ "network-online.target" ];
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountOneDrive}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount onedrive: ${mountOneDrive} \ ${rcloneMountArgs}";
        ExecStop = "${pkgs.fuse}/bin/fusermount -u ${mountOneDrive}";
        Type = "notify";
        Restart = "always";
        RestartSec = "10s";
        Environment = [ "PATH=${pkgs.fuse}/bin:/run/wrappers/bin/:$PATH" ];
      };
    };
  };

  #----- System Configuration -----
}
