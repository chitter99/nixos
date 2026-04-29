{ nixpkgs, nixpkgs-unstable, ... }@inputs:
let
  config = import ./config.nix inputs;
  defaultHostOptions = {
    nvidia = false;
    powersave = false;
    theme = "aurora";
  };
in let
  hosts = map (key:
    let
      host = config.hosts."${key}";
      hostname = key;
      system = host.system;
      username = host.username;
      hostOptions = defaultHostOptions // host.options;
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ "electron-38.8.4" ];
      };
      extraModules =
        if nixpkgs.lib.attrsets.hasAttrByPath [ "modules" ] host then
          host.modules
        else
          [ ];
    in {
      name = hostname;
      value = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system hostname username hostOptions pkgs-unstable;
        } // inputs;
        modules = [ ./. { nixpkgs.hostPlatform = system; } ] ++ extraModules;
      };
    }) (builtins.attrNames config.hosts);
in { nixosConfigurations = builtins.listToAttrs hosts; }
