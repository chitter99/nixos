{ ... }:
{
  services.power-profiles-daemon.enable = true;
  services.tlp.enable = false;

  # Lid close behavior
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };

  # Battery critical action
  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 2;
    criticalPowerAction = "HybridSleep";
  };
}
