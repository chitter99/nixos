{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      libreoffice-qt
      texliveFull
      thunderbird
      gephi
      yubikey-manager
      spotify
      hexchat
      transmission_4-qt
      quickemu
      vlc
      anki
    ];
  };
  services.teamviewer.enable = true;
  services.transmission.enable = true;
  programs = { steam.enable = true; };
}
