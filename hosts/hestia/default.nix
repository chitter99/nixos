{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # AMD integrated gpu
  boot.initrd.kernelModules = [ "amdgpu" ];

  console.keyMap = lib.mkForce "us";
}
