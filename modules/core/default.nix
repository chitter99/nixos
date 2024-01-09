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
    "electron-25.9.0"
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

  environment.systemPackages = corePackages ++ devPackages;
  
  # Dont change.
  system.stateVersion = "23.05"; # Did you read the comment?
}
