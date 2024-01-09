{
  description = "Machine specific configuration flake.";
  # Defining package channels
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixgl.url = "github:guibou/nixGL";

    hyprland.url = "github:hyprwm/hyprland";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  
  # Defining flake import structure for packages
  outputs = { self, nixpkgs, nixos-hardware, nixgl, ... } @ attrs:
  let 
    system = "x86_64-linux";
  in { 
    # Lenovo laptop
    nixosConfigurations.nixos-arsch-lenovo = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit system;
            username = "arsch";
            hostname = "nixos-arsch-lenovo";
            displayConfig = "laptop";
            nvidia_bool = "disabled";
        } // attrs;        
        modules = [
              ./.
              ./modules/toys
          ];
    };
    # Hestia framework laptop
    nixosConfigurations.hestia = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit system;
            username = "arsch";
            hostname = "hestia";
            displayConfig = "laptop";
            nvidia_bool = "disabled";
        } // attrs;        
        modules = [
              ./.
              ./modules/toys
              nixos-hardware.nixosModules.framework-13-7040-amd
          ];
     };
  };
}
