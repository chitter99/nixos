# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  stable = import <nixos-stable> { config = { allowUnfree = true;  }; };
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/yoga/6/13ALC6>
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "arsch-nixos-lenovo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Spotify firewall rules
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Screen brigthness
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Configure keymap in X11
  services.xserver = {
    layout = "ch";
    xkbVariant = "de_nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "sg";

  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];  
  
  # Polkit
  security.polkit.enable = true;

  # Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arsch = {
    isNormalUser = true;
    description = "Aaron Schmid";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
      firefox
      neofetch
      neovim
      vscode
      onedrive
      unstable.obsidian
      ungoogled-chromium
      spotify
      shotman
      slurp
      gimp
    ];
  };
  
  # Required
  security.pam.services.swaylock = {
    u2fAuth = true;
  };

  # Don't need sudo password
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable ozone
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     kitty
     hyprland
     xdg-desktop-portal-hyprland
     xdg-desktop-portal-gtk
     wlroots
     greetd.tuigreet 
     unstable.waybar
     hyprpaper
     rofi-wayland
     mako
     swaylock
     swayidle
     pulseaudio
     fishPlugins.done
     fishPlugins.fzf-fish
     fishPlugins.forgit
     fishPlugins.hydro
     fzf
     fishPlugins.grc
     grc
     cliphist
     ranger
     pcmanfm
     vlc
     xdg-utils
     polkit-kde-agent
     yubikey-personalization
     yubikey-personalization-gui
     yubikey-manager
     yubikey-manager-qt
     yubikey-touch-detector
  ];

  # Auto mount devices
  services.gvfs.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  
  #services.xserver = {
  #  enable = true;
  #  displayManager.gdm = {
  #    enable = true;
  #    wayland = true;
  #  };
  #};
  hardware.opengl.enable = true;

  # Enable display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${pkgs.hyprland}/bin/Hyprland";
      };
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    xwayland.hidpi = true;
    #package = unstable.hyprland.overwrite {
    #  enable = true;
    #  xwayland.enable = true;
    #};
  };
  xdg.portal.enable = true;
  
  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
      set number
      '';
    };
  };

  # Fish shell
  programs.fish.enable = true;

  # Direnv
  programs.direnv.enable = true;

  # PipeWire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "arsch" ];
  };

  services.transmission = { 
    enable = true; #Enable transmission daemon
    openRPCPort = true; #Open firewall for RPC
    settings = { #Override default settings
      rpc-bind-address = "0.0.0.0"; #Bind to own IP
      rpc-whitelist = "127.0.0.1,10.0.0.1"; #Whitelist your remote machine (10.0.0.1 in this example)
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
