{ nixpkgs, nixos-hardware, ... }:
let
  system = "x86_64-linux";
  username = "arsch";
in {
  hosts = {
    hestia = {
      inherit system;
      inherit username;
      options = {
        nvidia = false;
        powersave = true;
        theme = "aurora";
      };
      modules = [ nixos-hardware.nixosModules.framework-13-7040-amd ];
    };
    gaia = {
      inherit system;
      inherit username;
      options = {
        nvidia = false;
        powersave = true;
        theme = "aurora";
      };
    };
  };
}
