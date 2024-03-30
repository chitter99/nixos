{ pkgs, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [ hypridle ];
  home-manager.users.${username} = { ... }: {
    home.file = {
      ".config/hypr/hypridle.conf".source = ./dots/hypridle.conf;
    };
  };
}
