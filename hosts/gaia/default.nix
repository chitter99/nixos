{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  console.keyMap = lib.mkForce "sg";
}
