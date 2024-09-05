{ pkgs, lib, config, inputs, ... }: {
  languages.nix.enable = true;
  pre-commit.hooks.nixfmt.enable = true;
}
