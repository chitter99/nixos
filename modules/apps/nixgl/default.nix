{ nixpkgs, nixgl, system, nvidia_bool, ... }:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ nixgl.overlay ];
  };
in
{
  environment.systemPackages = if nvidia_bool == "nixVulkanIntel" then [
    pkgs.nixgl.auto.nixGLNvidia
  ] else [
    pkgs.nixgl.nixVulkanIntel
  ];
}
