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
in {
  #----- Home Manager Config -----
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [ openfortivpn ];
    home.file = {
      ".vpn/neture".text = ''
        host = neture.ch
        port = 10443
        username = aarsch
        set-dns = 0
        pppd-use-peerdns = 0
        # X509 certificate sha256 sum, trust only this one!
        trusted-cert = b88e832db8ae7fabd0209d56ec501fdad4e66b78dc44308ff37edf13aaf83d6b
      '';
      ".vpn/msh".text = ''
        host = 212.51.138.190
        port = 10443
        username = msh.aschmid
        set-dns = 0
        pppd-use-peerdns = 0
      '';
    };
  };
}
