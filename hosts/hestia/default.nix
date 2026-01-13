{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Override auto-cpufreq options
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "auto";
      scaling_min_freq = 1800000;
    };
    charger = {
      governor = "performance";
      turbo = "auto";
      scaling_min_freq = 3300000;
      scaling_max_freq = 5100000;
    };
  };

  # Framework amd 13inch specific hardware patches
  services.fwupd.enable = true;
  #hardware.framework.amd-7040.preventWakeOnAC = true;

  # AMD integrated gpu
  hardware.opengl.extraPackages = with pkgs; [ amdvlk ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  console.keyMap = lib.mkForce "us";
}
