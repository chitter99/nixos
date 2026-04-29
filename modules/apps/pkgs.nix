{ pkgs, pkgs-unstable, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      libreoffice-qt
      texliveSmall
      thunderbird
      gephi
      yubikey-manager
      spotify
      #quickemu
      vlc
      anki
      gimp3
      zotero
      todoist-electron
      networkmanagerapplet
      xournalpp
      kdePackages.okular
      #pkgs-unstable.lmstudio # pinned-unstable: AI tool, rapid updates — revisit on nixos-25.11
      pkgs-unstable.beeper # pinned-unstable: chat client, version-sensitive — revisit on nixos-25.11
    ];
  };
  services.teamviewer.enable = true;
  #services.transmission.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];
}
