{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      teamviewer
      rustdesk
      libreoffice-qt
      texliveFull
      thunderbird
      gephi
      yubikey-manager
      spotify
      rustdesk
      hexchat
      transmission_4-qt
    ];
  };
  services.teamviewer.enable = true;
  services.transmission.enable = true;
  programs = {
    steam.enable = true;
  };
}
