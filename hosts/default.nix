{ pkgs, home-manager, username, hostname, ... }:
{
  imports = [
    ./${hostname}
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;
  };
  # ---- System Configurations ----
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
  };
  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Enable OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
    
  services.xserver = {
    layout = "ch";
    xkbVariant = "de_nodeadkeys";
  };

  console.keyMap = "sg";
}
