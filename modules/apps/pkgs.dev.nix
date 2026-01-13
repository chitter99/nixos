{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    # TODO: Remove, bad bad bad
    home.sessionPath = [ "/home/arsch/.local/bin" ];
    home.packages = with pkgs; [
      cargo
      gcc
      cmake
      gnumake
      go
      nim
      nix-prefetch-git
      nodejs_20
      postgresql_15
      python312
      python312Packages.pip
      python312Packages.pipx
      zig
      mysql-workbench
      mysql80
      mongodb-compass
      bruno
      robo3t
      filezilla
      devenv
      jq
      netcat-gnu
      dig
      azuredatastudio
      neo4j-desktop
      pgadmin4
      dbeaver-bin
      speedtest-cli
      openvpn3
      openvpn
    ];
  };
}

