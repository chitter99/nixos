{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ mako ];
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/mako/config".source = ./dots/config;
    };
  };
}
