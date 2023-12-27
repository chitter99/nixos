{ pkgs, home-manager, username, nix-vscode-extensions, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userEmail = "aaron@clab.rocks";
      userName = "Aaron Schmid";
    };
  };
  environment.systemPackages = with pkgs; [ 
    git
  ];
}
