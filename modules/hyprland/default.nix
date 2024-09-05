{ pkgs, username, ... }: {
  imports = [ ./hypr ./mako ./waybar ./wofi ./greetd.nix ];

  xdg = { portal = { enable = true; }; };

  # Source: https://wiki.hyprland.org/Nix/
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
  ];
}

