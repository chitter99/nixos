{ pkgs, home-manager, username, ... }:
let
  rstudio = pkgs.rstudioWrapper.override{
    packages = with pkgs.rPackages; []; 
  };
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [ rstudio ];
  };
}
