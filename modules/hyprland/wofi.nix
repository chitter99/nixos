{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ wofi ];
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/wofi/config".source = ./dots/wofi;
      ".config/wofi/style.css".source = ./dots/wofi.css;
    };
  };
}
