{ system, openconnect-sso, username, ... }:
/* let
     openconnectOverlay = import (
       builtins.fetchTarball {
         url = "https://github.com/vlaci/openconnect-sso/archive/master.tar.gz";
         sha256 = "08cqd40p9vld1liyl6qrsdrilzc709scyfghfzmmja3m1m7nym94";
       }
     )/overlay.nix;
     pkgs = import nixpkgs {
       inherit system;
       overlays = [ openconnectOverlay ];
     };
   in
*/
{
  home-manager.users.${username} = { home, ... }: {
    home.packages = [ openconnect-sso.packages.${system}.openconnect-sso ];
  };
}
