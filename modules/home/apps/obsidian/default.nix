{ system, nixpkgs, home-manager, username, ... }:
let 
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    # Needed as obsidian currently is using out of date electron version
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
in {
  home-manager.users.${username} = { home, ... }: {
    home.packages = with pkgs; [
      obsidian
      pandoc
    ];
  };
}
