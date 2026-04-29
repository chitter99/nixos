{
  description = "My super cool nix flake setup";
  nixConfig = {
    builders-use-substitutes = true;
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://devenv.cachix.org"
      "https://chitter99nixos.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "chitter99nixos.cachix.org-1:1s6eql7K1loHr4s0ancnzprKBIzT2s5OAQlOVxSsrsM="
    ];
    extra-experimental-features = "nix-command flakes";
    trusted-users = ''
      root arsch
    '';
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs = args: import ./outputs.nix args;
}
