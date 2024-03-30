{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ wofi ];

  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/wofi/config".source = ./dots/config;
      ".config/wofi/style.css".source = ./dots/style.css;
    };
  };
}
