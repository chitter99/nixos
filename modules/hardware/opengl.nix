{ pkgs, ... }: {
  # Enable OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];
}
