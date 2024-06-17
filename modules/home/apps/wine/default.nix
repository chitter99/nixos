{ pkgs, ... }:
{
  # Source: https://nixos.wiki/wiki/Wine
  environment.systemPackages = with pkgs; [
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    winetricks
  ];
}
