{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      cargo
      gcc
      cmake
      gnumake
      go
      nim
      nix-prefetch-git
      nodejs_20
      powershell
      postgresql_15
      python312
      zig
      mysql-workbench
      mysql80
      mongodb-compass
      bruno
      robo3t
      filezilla
    ];
  };
}

