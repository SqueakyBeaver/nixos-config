{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./maps.nix
  ];

  programs.nixvim = {
    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    luaLoader.enable = true; # Why not

    colorschemes.kanagawa = {
      enable = true;
      settings = {
        compile = true;
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none";
              };
            };
          };
        };
        # Stylix stuff???
        overrides = config.lib.nixvim.mkRaw ''
            function(colors)
                local theme = colors.theme
                local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
            end

            return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            -- Make telescope look more modern I guess
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- more uniform colors for popup menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- tint bg of diagnostic messages
            DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),


           }
          end
        '';
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      nu = true;
      shiftwidth = 0;
      tabstop = 4;
      expandtab = true;
      splitbelow = true;
      cc = "80";
      wrap = false;
    };

    autoCmd = [
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

    autoGroups = {
      lsp_attach_disable_ruff_hover = {
        clear = true;
      };
    };

    plugins = {
      direnv.enable = true;

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 4;
          multiline_threshold = 5;
        };
      };

      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
        };

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
            installRustc = true;
            installCargo = true;
          };
          ts_ls.enable = true;
          cssls.enable = true;
        };
      };

      luasnip.enable = true;

      blink-cmp = {
        enable = true;

        settings = {
          completion = {
            accept.auto_brackets = {
              enabled = true;
              semantic_token_resolution = {
                enabled = false;
              };
            };
            documentation.auto_show = true;
            trigger.show_in_snippet = false;
            list.selection = {
              preselect = false;
              auto_insert = false;
            };
          };

          signature = {
            enabled = true;
          };

          sources = {
            providers = {
              buffer = {
                score_offset = -7;
              };
              lsp = {
                fallbacks = [];
              };
            };
          };

          keymap = {
            "<C-Space>" = ["accept" "show_documentation" "hide_documentation" "fallback"];
            "<C-d>" = ["scroll_documentation_up" "fallback"];
            "<C-e>" = ["cancel" "fallback"];
            "<C-f>" = ["scroll_documentation_down" "fallback"];
            "<CR>" = ["accept" "fallback"];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
          };
        };
      };

      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 50;
            search_method = "cover_or_next";
          };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };

      telescope = {
        enable = true;

        settings = {
          defaults = {
            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "%.ipynb"
            ];
            layout_config = {
              prompt_position = "top";
            };
            mappings = {
              i = {
                "<A-j>" = {
                  __raw = "require('telescope.actions').move_selection_next";
                };
                "<A-k>" = {
                  __raw = "require('telescope.actions').move_selection_previous";
                };
              };
            };
            selection_caret = "> ";
            set_env = {
              COLORTERM = "truecolor";
            };
            sorting_strategy = "ascending";
          };
        };

        extensions = {
          fzf-native.enable = true;
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            cpp = ["clang_format"];
            javascript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              timeout_ms = 2000;
              stop_after_first = true;
            };
            python = [
              "ruff_fix"
              "ruff_format"
              "ruff_organize_imports"
            ];
            nix = [
              "alejandra"
              "injected"
            ];
            lua = [
              "stylua"
            ];

            "_" = [
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          log_level = "debug";
          notify_on_error = false;
          notify_no_formatters = false;
          default_format_opts.lsp_format = "fallback";
        };
      };

      toggleterm = {
        enable = true;
        settings.open_mapping = "[[<C-\\>]]";
      };

      twilight.enable = true;
      zen-mode = {
        enable = true;

        settings = {
          on_close = ''
            function()
              require("gitsigns.actions").toggle_current_line_blame()
              vim.cmd('IBLEnable')
              vim.cmd('GitBlameToggle')
              vim.opt.number = true
              require("gitsigns.actions").refresh()
            end
          '';
          on_open = ''
            function()
              require("gitsigns.actions").toggle_current_line_blame()
              vim.cmd('IBLDisable')
              vim.cmd('GitBlameToggle')
              vim.opt.number = false
              require("gitsigns.actions").refresh()
            end
          '';
          plugins = {
            gitsigns = {
              enabled = true;
            };

            options = {
              enabled = true;
              ruler = false;
              showcmd = false;
            };
            twilight = {
              enabled = false;
            };
          };
          window = {
            backdrop = 0.95;
            height = 1;
            options = {
              signcolumn = "no";
            };
            width = 0.8;
          };
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      multicursors = {
        enable = true;
      };

      auto-save.enable = true;

      barbar.enable = true;

      lazygit.enable = true;

      fidget.enable = true;

      lsp-lines.enable = true;

      comment.enable = true;

      cursorline.enable = true;

      dropbar.enable = true;

      gitblame.enable = true;

      lightline.enable = true;

      nix.enable = true;

      neo-tree.enable = true;

      neoclip.enable = true;

      which-key.enable = true;

      web-devicons.enable = true;

      gitsigns.enable = true;

      indent-blankline.enable = true;
    };
  };
}
