{ config, ... }: {
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  networking.firewall = {
    # enable the firewall
    enable = true;

    # always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];

    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];

    # allow you to SSH in over the public internet
    # allowedTCPPorts = [ 22 ];
  };

}
