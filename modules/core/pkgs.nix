{ pkgs, username, ... }: {
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

  environment.systemPackages = with pkgs; [
    # Systemctl
    brightnessctl
    pavucontrol
    playerctl
    ranger
    wirelesstools
    inetutils

    # Utils
    ripgrep
    unzip
    p7zip
    wget
    vim
    nfs-utils

    # Mics
    glxinfo
    exfat
    btop
    nitch
  ];
}
