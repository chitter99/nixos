{ pkgs, username, hostname, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  networking = {
    enableIPv6 = false;
    networkmanager.enable = true;
    hostName = "${hostname}";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 9090 3000 ];
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
    nameservers = [ "8.8.8.8" ];
    extraHosts = ''
      160.85.252.22 osi
    '';
  };
  users.users.${username} = { extraGroups = [ "networkmanager" ]; };
}
