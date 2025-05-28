{ pkgs, home-manager, username, system, ... }: {
  environment.systemPackages = with anyrun.packages.${system};
    [ anyrun-with-all-plugins ];

  home-manager.users.${username} = { ... }: {
    programs.anyrun = {
      enable = true;
      config = {
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.3; };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = false;
        showResultsImmediately = false;
        maxEntries = null;
      };

      # Inline comments are supported for language injection into
      # multi-line strings with Treesitter! (Depends on your editor)
      extraCss = # css
        ''
          .some_class {
            background: red;
          }
        '';

      extraConfigFiles."some-plugin.ron".text = ''
        Config(
          // for any other plugin
          // this file will be put in ~/.config/anyrun/some-plugin.ron
          // refer to docs of xdg.configFile for available options
        )
      '';
    };
  };
}
