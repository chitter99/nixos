{
  pkgs,
  pkgs-unstable,
  home-manager,
  username,
  system,
  nix-vscode-extensions,
  ...
}:
let
  vscodePackage = pkgs-unstable.vscode;
  vscodeExtensions =
    nix-vscode-extensions.extensions."${system}".forVSCodeVersion
      vscodePackage.version;
in
{
  home-manager.users.${username} =
    { pkgs, ... }:
    {
      # Jupiter notebook fix
      home.packages = with pkgs; [
        gcc-unwrapped
        nixd
        nixpkgs-fmt
        pkg-config
      ];
      home.sessionVariables = {
        # Hyprland fails to find gcc with this env variable
        #LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.gcc-unwrapped ];
      };
      # VS Code on Wayland has issues, make sure to set the title bar to custom
      # https://github.com/microsoft/vscode/issues/181533
      programs.vscode = {
        enable = true;
        package = vscodePackage; # pinned-unstable: fast-moving IDE, extensions need latest — revisit on nixos-25.11
        mutableExtensionsDir = true;
        profiles.default.enableUpdateCheck = false;
        profiles.default.enableExtensionUpdateCheck = false;
        profiles.default.userSettings = {
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
          #### ZHAW
          "remote.SSH.serverInstallPath" = {
            "losangeles.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "sanfrancisco.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "sandiego.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "sacramento.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "sanjose.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "fresko.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "trinity.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "honolulu.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
            "hilo.zhaw.ch" = "/raid/persistent_scratch/schmiaa2/";
          };
        };
        profiles.default.extensions = with vscodeExtensions.vscode-marketplace; [
          # Tools
          rubymaniac.vscode-direnv
          esbenp.prettier-vscode
          # LSP
          jnoortheen.nix-ide
          ms-python.python
          ms-python.debugpy
          rust-lang.rust-analyzer
          prisma.prisma
          hashicorp.terraform
          #ms-toolsai.jupyter
          reditorsupport.r
          james-yu.latex-workshop
          #nomicfoundation.hardhat-solidity
          juanblanco.solidity
          #bmewburn.vscode-intelephense-client
          # Theme
          monokai.theme-monokai-pro-vscode
        ];
      };
    };
}
