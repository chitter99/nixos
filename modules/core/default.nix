{ pkgs, home-manager, username, hostname, ... }:
let
  corePackages = import ./pkgs/core { inherit  pkgs; };
  devPackages = import ./pkgs/dev { inherit pkgs; };
in
{ 
  imports = [
    ./boot/systemd
    ./terminal
    ./security
  ];

  home-manager.users.${username} = { pkgs, ... }: {
    programs.gh.enable = true;
  };
  
  # Enable Flakes and nix-commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
          
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    # TODO: Remove again once CVE has been fixed
    # https://github.com/NixOS/nixpkgs/pull/294031
    "nix-2.16.2"
  ];

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "de_CH.UTF-8/UTF-8"
  ];

  programs.direnv = {
    enable = true;
    silent = true;
  };  

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      canon-cups-ufr2
      cnijfilter2
      gutenprint
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 9090 3000 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };


  # Auto mouting external devices
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Allow to cross compile arm
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = corePackages ++ devPackages;
  
  # Dont change.
  system.stateVersion = "23.05"; # Did you read the comment?
}
