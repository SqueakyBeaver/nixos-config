{ lib, inputs, ... }: {
  programs.nixvim = {
    keymaps =
      let
        normal = lib.mapAttrsToList
          (key: action: {
            mode = "n";
            inherit action key;
          })
          {
            # Based on lazyvim

            # Better up/down
            J = "v:count == 0 ? 'gj' : 'j'";
            "<Down>" = "v:count == 0 ? 'gj' : 'j'";
            K = "v:count == 0 ? 'gk' : 'k'";
            "<Up>" = "v:count == 0 ? 'gk' : 'k'";

            # Move to window using <ctrl> hjkl keys
            "<C-h>" = "<C-w>h";
            "<C-j>" = "<C-w>j";
            "<C-k>" = "<C-w>k";
            "<C-l>" = "<C-w>l";

            # Resize window using <ctrl> arrow keys
            "<C-Up>" = "<cmd>resize +2<cr>";
            "<C-Down>" = "<cmd>resize -2<cr>";
            "<C-Left>" = "<cmd>vertical resize -2<cr>";
            "<C-Right>" = "<cmd>vertical resize +2<cr>";

            # Move lines with <Alt> jk
            "<A-j>" = "<cmd>m .+1<cr>==";
            "<A-k>" = "<cmd>m .-2<cr>==";

            # Buffers
            "<S-h>" = "<cmd>bprevious<cr>";
            "<S-l>" = "<cmd>bnext<cr>";
            "[b" = "<cmd>bprevious<cr>";
            "]b" = "<cmd>bnext<cr>";
            "<leader>bb" = "<cmd>e #<cr>";
            "<leader>`" = "<cmd>e #<cr>";
            "<leader>bD" = "<cmd>:bd<cr>";
          };

        visual = lib.mapAttrsToList
          (key: action: {
            mode = "v";
            inherit action key;
          })
          {
            # Move lines with <Alt> jk
            "<A-j>" = ":m '>+1<cr>gv=gv";
            "<A-k>" = ":m '<-2<cr>gv=gv";

          };
        #  Move Lines with <Alt> jk
        #            i =             "<A-j>" = "<esc><cmd>m .+1<cr>==gi";
        #           "<A-k>" = "<esc><cmd>m .-2<cr>==gi";

      in
      (normal ++ visual);
  };
}
