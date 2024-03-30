{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ waybar ];
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/waybar/config.jsonc".source = ./dots/config.jsonc;
      ".config/waybar/style.css".source = ./dots/style.css;
    };
  };
}
