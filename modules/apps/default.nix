{ pkgs, home-manager, username, ... }:
{
  imports = [ 
    ./1password
    ./browsing
    ./rclone
    ./vscode
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
      discord
     ];
  };
}
