{ username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    xdg.userDirs.enable = true;
    xdg.userDirs.createDirectories = true;
  };
}
