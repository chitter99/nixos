{ pkgs, username, hostname, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  networking = {
    enableIPv6 = false;
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openconnect ];
      dns = "default";
    };
    hostName = "${hostname}";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 9090 3000 502 501 ];
      allowedUDPPorts = [ 1198 1197 ];
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
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  # services.resolved = {
  #   enable = true;
  #   fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  #   dnsovertls = "true";
  #   extraConfig = ''
  #     [Resolve]
  #     DNSStubListener=yes
  #     DNSStubListenerExtra=127.0.0.53
  #     Domains=~zhaw.ch
  #   '';
  # };

  users.users.${username} = { extraGroups = [ "networkmanager" ]; };
}
