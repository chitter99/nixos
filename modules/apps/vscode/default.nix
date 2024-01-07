{ pkgs, home-manager, username, nix-vscode-extensions, ... }:
{
  home-manager.users.${username} = { pkgs, ... }: {
    # VS Code on Wayland has issues, make sure to set the title bar to custom
    # https://github.com/microsoft/vscode/issues/181533
    programs.vscode = {
      enable = true;
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "window.titleBarStyle" = "custom";
      };
    };
    
    #programs.vscode = {
    #  enable = true;
    #  enableUpdateCheck = true;
    #  enableExtensionUpdateCheck = true;
      #extensions = with nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace; [
      #  vscodevim.vim
      #  bbenoist.nix
      #  ms-python.python
      #  cab404.vscode-direnv
        #r
        #monokai.theme-monokai-pro-vscode
      #];
#      userSettings = {
#         "window.titleBarStyle" = "custom";
#         "workbench.colorTheme" = "Github Dark Colorblind (Beta)";
#         "editor.fontFamily" = "'M+1Code Nerd Font','Droid Sans Mono', 'monospace', monospace";
#         "github.copilot.enable" = {
#           "*" = true;
#           "plaintext" = false;
#           "markdown" = true;
#           "scminput" = false;
#         };
#         "powershell.powerShellAdditionalExePaths" = "/run/current-system/sw/bin/pwsh";
#      };
      #userSettings = {
        #"workbench.colorTheme": "Monokai Pro (Filter Machine)";
       # "[python]" = {
       #   "editor.formatOnType" = true;
       #   "editor.formatOnSave" = true;
       #   "editor.formatOnPaste" = false;
        #};
        #"workbench.iconTheme": "Monokai Pro (Filter Machine) Icons",
       # "editor.mouseWheelZoom" = true;
        #"azure.resourceFilter": [
        #  "18653f8f-54e1-47bc-b075-fc90c8d9576b/59dde028-895c-45de-b2fa-deee26b0c1f4"
        #],
        #"solidity.telemetry": true,
        #"[jsonc]" = {
        #  "editor.defaultFormatter" = "esbenp.prettier-vscode";
        #};
        #"editor.defaultFormatter" = "esbenp.prettier-vscode";
        #"editor.formatOnSave" = true;
        #"javascript.updateImportsOnFileMove.enabled" = "always";
      #};
    #};
  };
}
