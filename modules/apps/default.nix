{ pkgs, home-manager, username, ... }:
{
  imports = [ 
    ./1password
    ./browsing
    ./rclone
    ./vscode
    ./helix
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
      discord
      teamviewer
     ];
  };
  services.teamviewer.enable = true;
}
