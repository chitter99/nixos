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
    ./obsidian
    ./rstudio
    ./openvpn
    ./wine
    ./gnome
    #./neovim
    ./tailscale
    #./pgadmin
    ./pkgs.dev.nix
    ./pkgs.nix
    ./nh
    ./gaming
    ./tmux
    ./ollama
  ];
}
