{ pkgs, username, ... }: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpicker
    hypridle
    hyprlock
    hyprpaper
  ];

  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/hypr/hypridle.conf".source = ./dots/hypridle.conf;
      ".config/hypr/hyprland.conf".source = ./dots/hyprland.conf;
      ".config/hypr/hyprlock.conf".source = ./dots/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ./dots/hyprpaper.conf;
    };
  };
}

