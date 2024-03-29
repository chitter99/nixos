{ pkgs, username, ... }:
{
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

    # Utils
    ripgrep
    unzip
    wget
    vim

    # Mics
    glxinfo
    exfat
    btop
    nitch
  ];
}
