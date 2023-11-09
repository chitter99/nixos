{ home-manager, username, ... }:
{
  home-manager.users.${username} =  { ... }: {
    home.file = {
      ".config/kitty/kitty.conf".text = ''
background #0F0F0F
background_opacity 1.0
      '';     
    };
  };
}
