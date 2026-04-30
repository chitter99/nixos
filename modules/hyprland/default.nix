{
  pkgs,
  pkgs-unstable,
  username,
  hostOptions,
  ...
}:
{
  imports = [
    ./hypr
    ./mako
    ./waybar
    ./wofi
    ./greetd.nix
    ./anyrun
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs-unstable.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  # Source: https://wiki.hyprland.org/Nix/
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  }
  // (if hostOptions.nvidia then { WLR_NO_HARDWARE_CURSORS = "1"; } else { });

  environment.systemPackages = with pkgs; [
    # Screenshot
    grim
    slurp

    # Clipboard mangr
    wl-clipboard

    # QT
    libsForQt5.qt5.qtwayland
    qt6.qtwayland

    # Mics
    lxqt.lxqt-policykit
    nwg-displays
  ];
}
