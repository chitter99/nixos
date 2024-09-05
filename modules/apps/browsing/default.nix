{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };

    programs = {
      chromium.enable = true;
      firefox.enable = true;
    };
  };
  programs = {
    chromium = {
      enable = true;
      extraOpts = {
        "BrowserSignin" = 1;
        "SyncDisabled" = false;
        "PasswordManagerEnabled" = false;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [ "en-US" ];
      };
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
      ];
    };
    firefox = { enable = true; };
  };
  environment.systemPackages = with pkgs; [ brave ];
}
