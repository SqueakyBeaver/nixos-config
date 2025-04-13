{config, ...}: {
  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "<C-b>";
      action = "<ESC>^i";
      options = {desc = "move beginning of line";};
    }
    {
      mode = "i";
      key = "<C-e>";
      action = "<End>";
      options = {desc = "move end of line";};
    }
    {
      mode = "i";
      key = "<C-h>";
      action = "<Left>";
      options = {desc = "move left";};
    }
    {
      mode = "i";
      key = "<C-l>";
      action = "<Right>";
      options = {desc = "move right";};
    }
    {
      mode = "i";
      key = "<C-j>";
      action = "<Down>";
      options = {desc = "move down";};
    }
    {
      mode = "i";
      key = "<C-k>";
      action = "<Up>";
      options = {desc = "move up";};
    }

    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {desc = "switch window left";};
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {desc = "switch window right";};
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {desc = "switch window down";};
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {desc = "switch window up";};
    }

    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options = {desc = "general clear highlights";};
    }

    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options = {desc = "general save file";};
    }
    {
      mode = "n";
      key = "<C-c>";
      action = "<cmd>%y+<CR>";
      options = {desc = "general copy whole file";};
    }
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>qa<CR>";
      options = {desc = "Quit all";};
    }

    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>set nu!<CR>";
      options = {desc = "toggle line number";};
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {desc = "toggle relative number";};
    }

    {
      mode = "n";
      key = "<leader>fm";
      action = config.lib.nixvim.mkRaw ''
        function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end'';
      options = {desc = "general format file";};
    }

    {
      mode = "n";
      key = "<leader>ds";
      action = "vim.diagnostic.setloclist";
      options = {desc = "LSP diagnostic loclist";};
    }

    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>enew<CR>";
      options = {desc = "buffer new";};
    }

    {
      mode = "n";
      key = "<leader>/";
      action = "gcc";
      options = {
        desc = "toggle comment";
        remap = true;
      };
    }
    {
      mode = "v";
      key = "<leader>/";
      action = "gc";
      options = {
        desc = "toggle comment";
        remap = true;
      };
    }

    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>Neotree filesystem reveal toggle<CR>";
      options = {desc = "neo-tree toggle window";};
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree filesystem reveal<CR>";
      options = {desc = "neo-tree focus/open window";};
    }

    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep<CR>";
      options = {desc = "telescope live grep";};
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options = {desc = "telescope find buffers";};
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options = {desc = "telescope help page";};
    }
    {
      mode = "n";
      key = "<leader>ma";
      action = "<cmd>Telescope marks<CR>";
      options = {desc = "telescope find marks";};
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = "<cmd>Telescope oldfiles<CR>";
      options = {desc = "telescope find oldfiles";};
    }
    {
      mode = "n";
      key = "<leader>fz";
      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      options = {desc = "telescope find in current buffer";};
    }
    {
      mode = "n";
      key = "<leader>cm";
      action = "<cmd>Telescope git_commits<CR>";
      options = {desc = "telescope git commits";};
    }
    {
      mode = "n";
      key = "<leader>gt";
      action = "<cmd>Telescope git_status<CR>";
      options = {desc = "telescope git status";};
    }
    {
      mode = "n";
      key = "<leader>pt";
      action = "<cmd>Telescope terms<CR>";
      options = {desc = "telescope pick hidden term";};
    }

    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options = {desc = "telescope find files";};
    }
    {
      mode = "n";
      key = "<leader>fa";
      action = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>";
      options = {desc = "telescope find all files";};
    }

    {
      mode = "n";
      key = "<leader>wK";
      action = "<cmd>WhichKey <CR>";
      options = {desc = "whichkey all keymaps";};
    }

    {
      mode = "n";
      key = "<leader>wk";
      action = config.lib.nixvim.mkRaw ''
        function()
          vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
        end'';
      options = {desc = "whichkey query lookup";};
    }

    {
      mode = "n";
      key = "gD";
      action = "vim.lsp.buf.declaration";
      options = {desc = "Go to declaration";};
    }
    {
      mode = "n";
      key = "gd";
      action = "vim.lsp.buf.definition";
      options = {desc = "Go to definition";};
    }
    {
      mode = "n";
      key = "gi";
      action = "vim.lsp.buf.implementation";
      options = {desc = "Go to implementation";};
    }
    {
      mode = "n";
      key = "<leader>sh";
      action = "vim.lsp.buf.signature_help";
      options = {desc = "Show signature help";};
    }
    {
      mode = "n";
      key = "<leader>wa";
      action = "vim.lsp.buf.add_workspace_folder";
      options = {desc = "Add workspace folder";};
    }
    {
      mode = "n";
      key = "<leader>wr";
      action = "vim.lsp.buf.remove_workspace_folder";
      options = {desc = "Remove workspace folder";};
    }
    {
      mode = "n";
      key = "<leader>wl";
      action = config.lib.nixvim.mkRaw ''
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
      '';
      options = {desc = "List workspace folders";};
    }
    {
      mode = "n";
      key = "<leader>D";
      action = "vim.lsp.buf.type_definition";
      options = {desc = "Go to type definition";};
    }
    {
      mode = ["n" "v"];
      key = "<leader>ca";
      action = "vim.lsp.buf.code_action";
      options = {desc = "Code action";};
    }
    {
      mode = "n";
      key = "gr";
      action = "vim.lsp.buf.references";
      options = {desc = "Show references";};
    }

    {
      mode = "n";
      key = "<leader>wz";
      action = "<cmd>ZenMode<CR>";
      options = {desc = "toggle zen mode";};
    }
  ];
}
