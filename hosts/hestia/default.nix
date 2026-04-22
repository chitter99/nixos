{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Override auto-cpufreq options
  services.auto-cpufreq.enable = lib.mkForce false;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      energy_performance_preference = "power";
      turbo = "auto";
    };
    charger = {
      governor = "powersave";
      energy_performance_preference = "balance_performance";
      turbo = "auto";
      #scaling_min_freq = 1800000;
      #scaling_max_freq = 5100000;
    };
  };

  services.power-profiles-daemon.enable = lib.mkForce true;

  # Framework amd 13inch specific hardware patches
  services.fwupd.enable = true;
  #hardware.framework.amd-7040.preventWakeOnAC = true;

  # AMD integrated gpu
  boot.initrd.kernelModules = [ "amdgpu" ];

  console.keyMap = lib.mkForce "us";
}
