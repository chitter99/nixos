{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    programs.git = {
      enable = true;
      settings.user.email = "aaron@clab.rocks";
      settings.user.name = "Aaron Schmid";
    };
  };
  environment.systemPackages = with pkgs; [ git git-lfs ];
}
