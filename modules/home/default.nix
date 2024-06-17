{ hostOptions, username, ... }: {
  home-manager.users.${username} = { ... }: {
    # The home.stateVersion option does not have a default and must be set
    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;

    imports = [
      ./apps
      ./hyprland
      ./terminal
    ] ++ (if hostOptions.dev then [ ./toys ] else [ ])
    ++ (if hostOptions.toys then [ ./dev ./nvim ] else [ ]);
  };

  home-manager.users.${username} = { ... }: {
    programs.git.enable = true;
    programs.vim.enable = true;
  };

  programs = {
    htop.enable = true;
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
