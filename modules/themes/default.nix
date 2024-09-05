{ nixpkgs, hostOptions, ... }: {
  imports = nixpkgs.lib.optional (builtins.pathExists ./${hostOptions.theme})
    ./${hostOptions.theme};
}
