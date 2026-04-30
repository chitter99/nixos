{ home-manager, username, ... }:
{
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users.${username} = {
    imports = [ ];
  };
}
