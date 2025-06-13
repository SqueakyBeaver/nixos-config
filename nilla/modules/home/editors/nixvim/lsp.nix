{config, ...}: {
  config = {
    programs.nixvim.autoCmd = [
      {
        group = "lsp_attach_disable_ruff_hover";
        callback = config.lib.nixvim.mkRaw ''
          function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client == nil then
              return
            end
            if client.name == 'ruff' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end
        '';
        desc = "LSP: Disable hover capability from Ruff";
        event = "LspAttach";
      }
    ];

    programs.nixvim.autoGroups.lsp_attach_disable_ruff_hover = {
      clear = true;
    };

    programs.nixvim.lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
        }
        {
          key = "gi";
          lspBufAction = "implementation";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          action = config.lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          key = "<leader>k";
        }
        {
          action = config.lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
          key = "<leader>j";
        }
        {
          action = "<CMD>LspStop<Enter>";
          key = "<leader>lx";
        }
        {
          action = "<CMD>LspStart<Enter>";
          key = "<leader>ls";
        }
        {
          action = "<CMD>LspRestart<Enter>";
          key = "<leader>lr";
        }
        {
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
          key = "gd";
        }
      ];
      servers = {
        bashls.enable = true;
        basedpyright = {
          enable = true;
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off";
                # ignore = ["*"];
              };
              disableOrganizeImports = true;
            };
          };
        };
        clangd.enable = true;
        gopls.enable = true;
        html.enable = true;
        nil_ls.enable = true;
        ruff = {
          enable = true;
          settings = {
            lint = {
              select = [
                # pycodestyle
                "E"
                # Pyflakes
                "F"
                # pyupgrade
                "UP"
                # flake8-bugbear
                "B"
                # flake8-simplify
                "SIM"
                # isort
                "I"
              ];
            };
          };
        };
        rust_analyzer = {
          enable = true;
          settings = {
            installRustc = true;
            installCargo = true;
          };
        };
        ts_ls.enable = true;
        cssls.enable = true;
        omnisharp.enable = true;
        hls.enable = true;
        ltex.enable = true;
      };
    };

    programs.nixvim.plugins.lspconfig.enable = true;
  };
}
