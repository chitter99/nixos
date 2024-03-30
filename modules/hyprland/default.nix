{ pkgs, username, ... }:
{
  imports = [
    ./greetd.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./mako.nix
    ./waybar.nix
    ./wofi.nix
  ];

  programs.hyprland.enable = true;

  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/hypr/hyprpaper.conf".source = ./dots/hyprpaper.conf;
      ".config/hypr/hyprland.conf".source = ./dots/hyprland.conf;
    };
  };

  xdg = {
    portal = {
      enable = true;
    };
  };

  # Source: https://wiki.hyprland.org/Nix/
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker

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

