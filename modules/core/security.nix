{ pkgs, username, ... }:
{
  services.gnome = {
    gnome-keyring.enable = true;
  };

  security = {
    pam = {
      u2f.enable = true;
      services = {
        login.enableGnomeKeyring = true;
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
    polkit.enable = true;
  };
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.fprintd = {
    enable = false;
  };
  programs.gnupg.agent.enable = true;
}
