{ pkgs, home-manager, username, hostname, ... }: {
  imports = [ ./fish.nix ./kitty.nix ./starship.nix ];

  home-manager.users.${username} = { ... }: {
    home.shellAliases = {
      nrso = "sudo nixos-rebuild switch --flake ~/git/nixos#${hostname}";
      nrs = "nh os switch ~/git/nixos#${hostname}";
    };
  };
}
