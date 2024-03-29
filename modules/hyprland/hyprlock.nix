{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ hyprlock ];
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/hypr/hyprlock.conf".source = ./dots/hyprlock.conf;
    };
  };
}
