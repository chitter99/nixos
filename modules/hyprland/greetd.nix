{ pkgs, username, ... }: {
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
        user = username;
      };
    };
  };
}
