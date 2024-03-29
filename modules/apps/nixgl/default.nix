{ nixpkgs, nixgl, system, hostOptions, ... }:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ nixgl.overlay ];
  };
in
{
  environment.systemPackages =
    if hostOptions.nvidia then [
      pkgs.nixgl.auto.nixGLNvidia
    ] else [
      pkgs.nixgl.nixVulkanIntel
    ];
}
