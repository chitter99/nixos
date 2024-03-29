{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      canon-cups-ufr2
      cnijfilter2
      gutenprint
    ];
  };
  environment.systemPackages = with pkgs; [
    system-config-printer
    cups
    cups-filters
  ];
}
