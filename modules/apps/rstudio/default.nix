{ pkgs, home-manager, username, ... }:
let
  rstudio = pkgs.rstudioWrapper.override{
    packages = with pkgs.rPackages; []; 
  };
in
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [ rstudio ];
  };
}
