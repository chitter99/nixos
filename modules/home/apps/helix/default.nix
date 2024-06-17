{ pkgs, home-manager, username, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    home.file = {
          ".config/helix/config.toml".text = ''
          theme = "onedark"

          [editor]
          shell = ["fish", "-c"]
          line-number = "relative"

          [editor.lsp]
          display-inlay-hints = true
          '';
          ".config/helix/languages.toml".text = ''
          [language-server.rust-analyzer.config]
          inlayHints.typeHints.enable = true
          diagnostics.experimental.enable = true

          [language-server.ruff]
          command = "ruff-lsp"

          [language-server.ruff.config.settings]
          run = "onSave"
          
          [language-server.ruff.config.settings.lint]
          extend-select = [ "E501" ]
                    
          [[language]]
          name = "python"
          language-servers = [ "pylsp", "ruff" ]
          auto-format = true
          '';
    };
  };
  environment.systemPackages = with pkgs; [ 
    helix
  ];
}
