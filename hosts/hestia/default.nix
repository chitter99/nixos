{ nixos-hardware, lib, ... }: {
  # Config for framework laptop
  imports = [
    ./hardware-configuration.nix
  ];
  #----Host specific config ----
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
   };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  
  # Framework amd 13inch specific hardware patches
  services.fwupd.enable = true;
  #hardware.framework.amd-7040.preventWakeOnAC = true;

  #services.xserver = {
  #  layout = lib.mkForce "us";
  #};

  #console.keyMap = lib.mkForce "us";
}
