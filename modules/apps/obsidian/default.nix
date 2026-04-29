{ pkgs-unstable, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = [
      pkgs-unstable.obsidian # pinned-unstable: stable ships EOL electron — revisit on nixos-26.05
      pkgs.pandoc
    ];
  };
}
