{
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
}
