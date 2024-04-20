{ nixvim, ... }: {
  imports = [
    nixvim.homeManagerModules.nixvim
    ./plugins
    ./keymappings.nix
    ./options.nix
    ./todo.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
  };
}
