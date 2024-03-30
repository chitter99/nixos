{ pkgs, username, ... }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpicker
    hypridle
    hyprlock
    hyprpaper
  ];

  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/hypr/hypridle.config".source = ./dots/hypridle.conf;
      ".config/hypr/hyprland.config".source = ./dots/hyprland.conf;
      ".config/hypr/hyprlock.config".source = ./dots/hyprlock.conf;
      ".config/hypr/hyprpaper.config".source = ./dots/hyprpaper.conf;
    };
  };
}

