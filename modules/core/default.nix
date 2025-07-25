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
