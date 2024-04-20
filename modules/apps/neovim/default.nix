{ nixvim, home-manager, username, ... }:
{
  imports = [
    nixvim.nixosModules.nixvim
  ];
  home-manager.users.${username} = {
    imports = [
      nixvim.homeManagerModules.nixvim
    ];
    home.shellAliases = {
      v = "nvim";
    };
  };
  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    colorschemes.gruvbox.enable = true;

    plugins = {
      lightline.enable = true;
      telescope = {
        enable = true;

        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";

          # FZF like bindings
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };

        keymapsSilent = true;

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
      };
    };

    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      
      shiftwidth = 2;        # Tab width should be 2
    };
  };
}
