{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  console.keyMap = lib.mkForce "us";

  services.openssh.enable = true;
}
