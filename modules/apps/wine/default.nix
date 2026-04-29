{ pkgs, ... }: {
  # Source: https://nixos.wiki/wiki/Wine
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
  ];
}
