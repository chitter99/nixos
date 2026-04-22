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
      quickemu
      vlc
      anki
      gimp3
      zotero
      todoist-electron
      networkmanagerapplet
      xournalpp
      gephi
      lmstudio
      beeper
    ];
  };
  services.teamviewer.enable = true;
  #services.transmission.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];
}
