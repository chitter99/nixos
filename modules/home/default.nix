{ home-manager, username, nixvim, ... }: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users.${username} = { imports = [ ]; };
}
