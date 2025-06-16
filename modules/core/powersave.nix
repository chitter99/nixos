{ ... }: {
  services.auto-cpufreq.enable = true;
  # Need to disable as its enabled in the gnome stack
  # See https://discourse.nixos.org/t/cant-enable-tlp-when-upgrading-to-21-05/13435/2
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;
}
