{ pkgs, home-manager, username, hostname, ... }: {
  imports = [ ./fish.nix ./kitty.nix ./starship.nix ];

  home-manager.users.${username} = { ... }: {
    home.shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/git/nixos#${hostname}";
    };
  };
}
