{ pkgs, home-manager, username, system, nix-vscode-extensions, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    # Jupiter notebook fix
    home.packages = with pkgs; [
      gcc-unwrapped
      nixd
      nixpkgs-fmt
    ];
    home.sessionVariables = {
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
        pkgs.gcc-unwrapped
      ];
    };
    # VS Code on Wayland has issues, make sure to set the title bar to custom
    # https://github.com/microsoft/vscode/issues/181533
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Monokai Pro (Filter Machine)";        
        #"workbench.iconTheme" = "Monokai Pro (Filter Machine) Icons";
        "[python]" = {
          "editor.formatOnType" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = false;
        };
        "editor.mouseWheelZoom" = true; 
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        #### NixIDE
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "eval" = { };
            "formatting" = {
              "command" = "nixpkgs-fmt";
            };
            "options" = {
              "enable" = true;
              "target" = {
                "args" = [ ];
              };
            };
          };
        };
      };
      extensions = with (nix-vscode-extensions.extensions."${system}".forVSCodeVersion "1.86.2").vscode-marketplace; [
        # Tools
        rubymaniac.vscode-direnv
        esbenp.prettier-vscode
        # LGS
        jnoortheen.nix-ide
        ms-python.python
        rust-lang.rust-analyzer
        prisma.prisma
        ms-toolsai.jupyter
        #nomicfoundation.hardhat-solidity
        juanblanco.solidity
        bmewburn.vscode-intelephense-client
        # Theme
        monokai.theme-monokai-pro-vscode
      ];
    };    
  };
}
