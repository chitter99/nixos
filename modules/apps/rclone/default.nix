{ pkgs, home-manager, username, ... }:
{
  #----- Home Manager Config -----
  home-manager.users.${username} = { pkgs, ... }: {
  
    home.packages = with pkgs; [
      rclone
      fuse
     ];

    programs.rclone = {
      enable = true;
      
    };

    systemd.user.services.rclone-onedrive-brain = {
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      after = ["network.target"];
      description = "Mount brain from onedrive";
      serviceConfig = {
        Type = "notify";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p /home/${username}/onedrive/brain";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full onedrive: /home/${username}/onedrive";
        ExecStop = "fusermount -u /home/${username}/onedrive";
        Environment = [ "PATH=${pkgs.fuse}/bin:/run/wrappers/bin/:$PATH" ];
      };
    };
  };

  #----- System Configuration -----
  
}
