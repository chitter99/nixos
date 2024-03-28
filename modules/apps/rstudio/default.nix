{ pkgs, home-manager, username, ... }:
let
  rstudio = pkgs.rstudioWrapper.override{
    packages = with pkgs.rPackages; [
      base64enc
      digest 
      evaluate 
      glue 
      highr
      htmltools 
      jsonlite 
      knitr 
      magrittr
      markdown 
      mime 
      rmarkdown 
      stringi 
      stringr 
      xfun 
      yaml
      readr
      Rcpp
      tidyverse
      ggplot2
      kableExtra
    ]; 
  };
in
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [ rstudio ];
  };
}
