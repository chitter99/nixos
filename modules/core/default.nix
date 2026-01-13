{ pkgs, home-manager, username, hostname, hostOptions, ... }: {
  imports = [
    ./fonts
    ./terminal
    ./boot.nix
    ./network.nix
    ./pkgs.nix
    ./printing.nix
    ./security.nix
    ./virt.nix
    ./xdg.nix
  ] ++ (if hostOptions.powersave then [ ./powersave.nix ] else [ ]);

  # Enable Flakes and nix-commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.${username} = { pkgs, ... }: {
    # The home.stateVersion option does not have a default and must be set
    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;
  };
  nixpkgs.config.allowUnfree = true;

  # Localization
  time.timeZone = "Europe/Zurich";
  i18n = {
    supportedLocales =
      [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "de_CH.UTF-8/UTF-8" ];
    defaultLocale = "en_US.UTF-8";
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "ch,us";
    variant = "de_nodeadkeys";
  };
  console.keyMap = "sg";

  # Auto mouting external devices
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu70 # or try icu72, see below
      stdenv.cc.cc.lib
      icu
      zlib
      libunwind
      openssl
      curl
      libuuid
      krb5
      zstd
      glib
      libGL
      libsForQt5.qt5.qtbase
      qt5.full
      qtcreator
      dbus
      fontconfig
      freetype
      libxkbcommon
      wayland
      nss
      nspr

      # Qt / WebEngine / Qt infrastructure
      qt6.qtbase # Qt base framework
      qt6.full
      qt6.qtwayland
      qt6.qtwebengine # WebEngine module
      qt6.qtwebchannel # WebChannel (JS <-> C++)

      # Optionally, include a broader X11 set
      xorg.libX11
      xorg.libxcb
      xorg.xcbutilcursor
      xorg.libXext
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXrender
      xorg.libXdamage
      xorg.libXcomposite
      xorg.libXfixes
      xorg.libXtst
      xorg.libXi
      xorg.libxshmfence
      xorg.libxkbfile
      libdrm
      alsa-lib
      libgbm

    ];
  };

  # unixODBC
  environment.systemPackages = with pkgs; [ unixODBC ];
  environment.unixODBCDrivers = with pkgs.unixODBCDrivers; [
    sqlite
    psql
    msodbcsql18
  ];

  services.onedrive.enable = true;

  services.fwupd.enable = true;

  # Dont change.
  system.stateVersion = "23.05"; # Did you read the comment?
}
