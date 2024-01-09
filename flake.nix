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

    hyprland.url = "github:hyprwm/hyprland";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  
  # Defining flake import structure for packages
  outputs = { self, nixpkgs, nixos-hardware, ... } @ attrs: { 
    # Hyprland Desktop - 3 monitors 
    nixosConfigurations.retis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "eriim";
        hostname = "retis";
        displayConfig = "desktop";
        nvidia_bool = "enabled";
      } // attrs;        
      modules = [
            ./.
            ./modules/obs
            ./modules/toys
            ./modules/virt
          ];
    };#retis

    # Hyprland Laptop 
    nixosConfigurations.sisyphus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "eriim";
        hostname = "sisyphus";
        displayConfig = "laptop";
        nvidia_bool = "disabled";
      } // attrs;        
      modules = [
            ./.
          ];
    };#sisyphus
    # Appended new system
    nixosConfigurations.nixos-arsch-lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
            username = "arsch";
            hostname = "nixos-arsch-lenovo";
            displayConfig = "laptop";
            nvidia_bool = "disabled";
        } // attrs;        
        modules = [
              ./.
              ./modules/toys
          ];
    };#nixos-arsch-lenovo
    # Hestia framework
    nixosConfigurations.hestia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
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
