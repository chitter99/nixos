{ hostOptions, ... }: {
  imports = [ ./bluetooth.nix ./opengl.nix ./sound.nix ]
    ++ (if hostOptions.nvidia then [ ./nvidia.nix ] else [ ]);
}
