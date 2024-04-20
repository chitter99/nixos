{ pkgs, ... }:
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
    ./openvpn
    ./wine
    ./gnome
    ./neovim
    ./pkgs.dev.nix
    ./pkgs.nix
  ];
}
