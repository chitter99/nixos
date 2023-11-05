{ pkgs, username, ... }:
{
# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arsch = {
    shell = pkgs.bash;
    isNormalUser = true;
    initialPassword = "123456";
    extraGroups = [ "wheel" "input" "render" "audio" "networkmanager" ];
  };
}
