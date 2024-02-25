{ pkgs, home-manager, username, ... }:
{
  imports = [ 
    ./1password
    ./browsing
    ./rclone
    ./vscode
    ./helix
    ./ledger
    ./git
    ./nixgl
    ./obsidian
    ./rstudio
    ./docker
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      teamviewer
      rustdesk
      libreoffice-qt
      texliveFull
      thunderbird
     ];
  };
  services.teamviewer.enable = true;
}
