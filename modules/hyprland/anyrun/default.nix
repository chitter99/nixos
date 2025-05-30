{ pkgs, username, system, ... }: {
  home-manager.users.${username} = { ... }: {
    programs.anyrun = {
      enable = true;
      config = {
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.5; };

        layer = "overlay";
        closeOnClick = true;

        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/libkidex.so"
          "${pkgs.anyrun}/lib/librink.so"
          "${pkgs.anyrun}/lib/libshell.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
          "${pkgs.anyrun}/lib/libtranslate.so"
          "${pkgs.anyrun}/lib/libwebsearch.so"
        ];
      };
      extraCss = # css
        ''
          #window {
            background-color: rgba(0, 0, 0, 0);
          }

          box#main {
            border-radius: 10px;
            background-color: @theme_bg_color;
          }

          list#main {
            background-color: rgba(0, 0, 0, 0);
            border-radius: 10px;
          }

          list#plugin {
            background-color: rgba(0, 0, 0, 0);
          }

          label#match-desc {
            font-size: 10px;
          }

          label#plugin {
            font-size: 14px;
          }
        '';
    };
  };
}
