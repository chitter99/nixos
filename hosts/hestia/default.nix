{ nixos-hardware, ... }: {
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
  modules = {
    <nixos-hardware/framework/13-inch/7040-amd>
  };
  services.fwupd.enable = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;
}
