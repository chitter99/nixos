{ nixpkgs, hostname, ... }: {
  imports =
    nixpkgs.lib.optional (builtins.pathExists ./${hostname}) ./${hostname};
}
