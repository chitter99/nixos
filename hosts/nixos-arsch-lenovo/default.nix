{ pkgs, ... }: {
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
  #---AMD Integrated GPU---#
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
}
