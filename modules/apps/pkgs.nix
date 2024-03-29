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
    ];
  };
  services.teamviewer.enable = true;
  programs = {
    steam.enable = true;
  };
}
