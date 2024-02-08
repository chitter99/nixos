{ pkgs, home-manager, username, nix-vscode-extensions, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
}
