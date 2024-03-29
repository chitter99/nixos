{ pkgs, username, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "virbr0" ];
  };
  environment.systemPackages = with pkgs; [ virt-manager virt-viewer ];
  users.users.${username}.extraGroups = [ "libvirtd" "docker" ];
}
