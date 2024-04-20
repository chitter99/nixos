{
  description = "My super cool nix flake setup";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixgl.url = "github:guibou/nixGL";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = args: import ./outputs.nix args;
}
