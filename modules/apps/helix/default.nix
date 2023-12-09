
{ pkgs, home-manager, username, nix-vscode-extensions, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.file = {
          ".config/helix/config.toml".text = ''
          theme = "onedark"

          [editor]
          shell = ["fish", "-c"]
          '';
          ".config/helix/language.toml".text = ''
          [[language]]
          name = "rust"

          [language.config.hints]
          assignVariableTypes = true
          compositeLiteralFields = true
          constantValues = true
          functionTypeParameters = true
          parameterNames = true
          rangeVariableTypes = true
          '';
    };
  };
  environment.systemPackages = with pkgs; [ 
    helix
  ];
}
