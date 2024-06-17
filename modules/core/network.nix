{ username, hostname, ... }:
{
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
    firewall = {
      enable = true;
    };
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };
  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
