{ pkgs, lib, config, ... }:
let
  quarto = pkgs.vimUtils.buildVimPlugin {
    pname = "quarto-nvim";
    version = "v0.18.9";
    src = pkgs.fetchFromGitHub {
      owner = "quarto-dev";
      repo = "quarto-nvim";
      rev = "67e09027b5d8bd948907734fc6fb15028ffdcd28";
      # Uncomment to find new sha
      # sha256 = lib.fakeSha256;
      sha256 = "JRRwiY69GSIUSPslvVDL5VRZdtnYeZ2smyAw2ysu5B4=";
    };
  };
in {
  programs.nixvim = {
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [ imagemagick ];
    extraPython3Packages = p:
      with p; [
        pynvim
        jupyter-client
        cairosvg
        pnglatex
        plotly
        pyperclip
        jupytext
      ];
    extraPlugins = [ quarto ];
    plugins = {
      molten = {
        enable = true;
        settings = { image_provider = "image.nvim"; };
      };
      image = { enable = true; };
      jupytext = {
        enable = true;
        settings = {
          style = "markdown";
          output_extension = "md";
          force_ft = "markdown";
        };
      };
    };
    keymaps = let
      normal = lib.mapAttrsToList (key: action: {
        mode = "n";
        inherit action key;
      }) {
        "<localleader>mi" = ":MoltenInit<CR>";
        "<localleader>e" = ":MoltenEvaluateOperator<CR>";
        "<localleader>rl" = ":MoltenEvaluateLine<CR>";
        "<localleader>rr" = ":MoltenReevaluateCell<CR>";
        "<localleader>r" = ":<C-u>MoltenEvaluateVisual<CR>gv";
        "<localleader>rd" = ":MoltenDelete<CR>";
        "<localleader>oh" = ":MoltenHideOutput<CR>";
        "<localleader>os" = ":noautocmd MoltenEnterOutput<CR>";
      };
    in config.nixvim.helpers.keymaps.mkKeymaps { options.silent = true; }
    (normal);
  };
}
