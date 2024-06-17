{ pkgs, ... }:
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
    polkit = {
      enable = true;
      debug = true;
      extraConfig = ''
        /* Log authorization checks. */
        polkit.addRule(function(action, subject) {
          polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
        });       
      '';
    };
  };
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.fprintd = {
    enable = false;
  };
  programs.gnupg.agent.enable = true;
}

