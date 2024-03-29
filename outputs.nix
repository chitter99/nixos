{ nixpkgs, ... } @ inputs:
let
  config = import ./config.nix inputs;
  defaultHostOptions = {
    nvidia = false;
    powersave = false;
    theme = "something";
  };
in
let
  hosts =
    map
      (
        key:
        let
          host = config.hosts."${key}";
          hostname = key;
          system = host.system;
          username = host.username;
          hostOptions = defaultHostOptions // host.options;
          extraModules = if nixpkgs.lib.attrsets.hasAttrByPath [ "modules" ] host then host.modules else [ ];
        in
        {
          name = hostname;
          value = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit system;
              inherit hostname;
              inherit username;
              inherit hostOptions;
            } // inputs;
            modules = [
              ./.
            ] ++ extraModules;
          };
        }
      )
      (builtins.attrNames config.hosts);
in
{
  nixosConfigurations = builtins.listToAttrs hosts;
}
