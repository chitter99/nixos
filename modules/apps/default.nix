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
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      teamviewer
      rustdesk
     ];
  };
  services.teamviewer.enable = true;
}
