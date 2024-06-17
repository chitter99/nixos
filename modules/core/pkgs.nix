{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Systemctl
    brightnessctl
    pavucontrol
    playerctl
    ranger
    wirelesstools

    # Utils
    ripgrep
    unzip
    p7zip
    wget
    vim
    nfs-utils
    git

    # Mics
    glxinfo
    exfat
    btop
    nitch
  ];
}
