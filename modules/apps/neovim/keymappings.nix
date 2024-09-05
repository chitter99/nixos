{ config
, lib
, ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "<Space>" = "<NOP>";

              # Esc to clear search results
              "<esc>" = ":noh<CR>";

              # fix Y behaviour
              Y = "y$";

              # back and fourth between the two most recent files
              "<C-c>" = ":b#<CR>";

              # close by Ctrl+x
              "<C-x>" = ":close<CR>";

              # save by Space+s or Ctrl+s
              "<leader>s" = ":w<CR>";
              "<C-s>" = ":w<CR>";

              # window navigation
              #"<leader>h" = "<C-w>h";
              #"<leader>j" = "<C-w>j";
              #"<leader>k" = "<C-w>k";
              #"<leader>l" = "<C-w>l";

              # Press 'H', 'L' to jump to start/end of a line (first/last character)
              L = "$";
              H = "^";

              # resize with arrows
              "<C-Up>" = ":resize -2<CR>";
              "<C-Down>" = ":resize +2<CR>";
              "<C-Left>" = ":vertical resize +2<CR>";
              "<C-Right>" = ":vertical resize -2<CR>";

              # move current line up/down
              # M = Alt key
              "<M-k>" = ":move-2<CR>";
              "<M-j>" = ":move+<CR>";

              "<leader>rp" = ":!remi push<CR>";

              # Telescope
              # Find files using Telescope command-line sugar.
              "<leader>ff" = "<cmd>Telescope find_files<CR>";
              "<leader>fg" = "<cmd>Telescope live_grep<CR>";
              "<leader>b" = "<cmd>Telescope buffers<CR>";
              "<leader>fh" = "<cmd>Telescope help_tags<CR>";
              "<leader>fd" = "<cmd>Telescope diagnostics<CR>";

              # FZF like bindings
              "<C-p>" = "<cmd>Telescope git_files<CR>";
              "<leader>p" = "<cmd>Telescope oldfiles<CR>";
              "<C-f>" = "<cmd>Telescope live_grep<CR>";

              # Barbar
              "<TAB>" = "<cmd>BufferNext<CR>";
              "<S-TAB>" = "<cmd>BufferPrevious<CR>";
              "<C-w>" = "<cmd>BufferClose<CR>";
            };
        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              # better indenting
              ">" = ">gv";
              "<" = "<gv";
              "<TAB>" = ">gv";
              "<S-TAB>" = "<gv";

              # move selected line / block of text in visual mode
              "K" = ":m '<-2<CR>gv=gv";
              "J" = ":m '>+1<CR>gv=gv";
            };
      in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (normal ++ visual);
  };
}
