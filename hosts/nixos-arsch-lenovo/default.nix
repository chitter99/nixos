{ pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  #----Host specific config ----
  services.auto-cpufreq.enable = lib.mkDefault false;
  #---AMD Integrated GPU---#
  boot.initrd.kernelModules = [ "amdgpu" ];
}
