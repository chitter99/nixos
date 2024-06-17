{ pkgs, ... }:
{
  users.users.arsch = {
    shell = pkgs.fish;
    isNormalUser = true;
    initialPassword = "123456";
    extraGroups = [ "wheel" "input" "render" "audio" "networkmanager" "wireshark" ];
  };
}
