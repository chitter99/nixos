{ pkgs-unstable, username, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland; # pinned-unstable: fast-moving compositor — revisit on nixos-25.11
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = [
    pkgs-unstable.hyprpicker # pinned-unstable: must match hyprland version
    pkgs-unstable.hypridle # pinned-unstable: must match hyprland version
    pkgs-unstable.hyprlock # pinned-unstable: must match hyprland version
    pkgs-unstable.hyprpaper # pinned-unstable: must match hyprland version
  ];

  home-manager.users.${username} =
    { ... }:
    {
      home.file = {
        ".config/hypr/hypridle.conf".source = ./dots/hypridle.conf;
        ".config/hypr/hyprland.conf".source = ./dots/hyprland.conf;
        ".config/hypr/hyprlock.conf".source = ./dots/hyprlock.conf;
        ".config/hypr/hyprpaper.conf".source = ./dots/hyprpaper.conf;
      };
    };
}
