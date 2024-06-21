{ system, nixpkgs, home-manager, username, ... }:
let 
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    # Needed as obsidian currently is using out of date electron version
    config.permittedInsecurePackages = [
      "adobe-reader-9.5.5"
    ];
  };
in {
  home-manager.users.${username} = { home, ... }: {
    home.packages = with pkgs; [
        adobe-reader
    ];
  };
}
