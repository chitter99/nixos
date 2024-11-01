{ pkgs, username, ... }: {
  virtualisation.docker = { enable = true; };
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "virbr0" ];
  };
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager virt-viewer ];
  users.users.${username}.extraGroups = [ "libvirtd" "docker" "vboxusers" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
