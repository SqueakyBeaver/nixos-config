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

    colorschemes.gruvbox.enable = true;

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
                  typeCheckingMode = "basic";
                  ignore = ["*"];
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
          keymap = {
            preset = "super-tab";
            # "<C-Space>" = ["cmp.mapping.complete()" "fallback"];
            # "<C-d>" = ["cmp.mapping.scroll_docs(-4)" "fallback"];
            # "<C-e>" = ["cmp.mapping.close()" "fallback"];
            # "<C-f>" = ["cmp.mapping.scroll_docs(4)" "fallback"];
            # "<CR>" = ["cmp.mapping.confirm({ select = false })" "fallback"];
            # "<S-Tab>" = ["cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})" "fallback"];
            # "<Tab>" = [
            #   config.lib.nixvim.mkRaw
            #   ''
            #     function(fallback)
            #       if cmp.visible() then
            #         cmp.select_next_item()
            #       else
            #         require("intellitab").indent()
            #       end
            #     end
            #   ''
            #   "fallback"
            # ];
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

      bufferline = {
        enable = true;
        # mfw I'm just gonna copy the default config (it's late)
        settings = {
          highlights = {
            buffer_selected = {
              bg = "#363a4f";
            };
            fill = {
              bg = "#1e2030";
            };
            numbers_selected = {
              bg = "#363a4f";
            };
            separator = {
              fg = "#1e2030";
            };
            separator_selected = {
              bg = "#363a4f";
              fg = "#1e2030";
            };
            separator_visible = {
              fg = "#1e2030";
            };
            tab_selected = {
              bg = "#363a4f";
            };
          };
          options = {
            always_show_bufferline = true;
            buffer_close_icon = "󰅖";
            close_icon = "";
            custom_filter = ''
              function(buf_number, buf_numbers)
                -- filter out filetypes you don't want to see
                if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                    return true
                end
                -- filter out by buffer name
                if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    return true
                end
                -- filter out based on arbitrary rules
                -- e.g. filter out vim wiki buffer from tabline in your work repo
                if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                    return true
                end
                -- filter out by it's index number in list (don't show first buffer)
                if buf_numbers[1] ~= buf_number then
                    return true
                end
              end
            '';
            diagnostics = "nvim_lsp";
            diagnostics_indicator = ''
              function(count, level, diagnostics_dict, context)
                local s = ""
                for e, n in pairs(diagnostics_dict) do
                  local sym = e == "error" and " "
                    or (e == "warning" and " " or "" )
                  if(sym ~= "") then
                    s = s .. " " .. n .. sym
                  end
                end
                return s
              end
            '';
            enforce_regular_tabs = false;
            get_element_icon = ''
              function(element)
                -- element consists of {filetype: string, path: string, extension: string, directory: string}
                -- This can be used to change how bufferline fetches the icon
                -- for an element e.g. a buffer or a tab.
                -- e.g.
                local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
                return icon, hl
              end
            '';
            groups = {
              items = [
                {
                  highlight = {
                    fg = "#a6da95";
                    sp = "#494d64";
                    underline = true;
                  };
                  matcher = {
                    __raw = ''
                      function(buf)
                        return buf.name:match('%test') or buf.name:match('%.spec')
                      end
                    '';
                  };
                  name = "Tests";
                  priority = 2;
                }
                {
                  auto_close = false;
                  highlight = {
                    fg = "#ffffff";
                    sp = "#494d64";
                    undercurl = true;
                  };
                  matcher = {
                    __raw = ''
                      function(buf)
                        return buf.name:match('%.md') or buf.name:match('%.txt')
                      end
                    '';
                  };
                  name = "Docs";
                }
              ];
              options = {
                toggle_hidden_on_enter = true;
              };
            };
            indicator = {
              icon = "▎";
              style = "icon";
            };
            left_trunc_marker = "";
            max_name_length = 18;
            max_prefix_length = 15;
            mode = "buffers";
            modified_icon = "●";
            numbers = {
              __raw = ''
                function(opts)
                  return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
                end
              '';
            };
            offsets = [
              {
                filetype = "neo-tree";
                highlight = "Directory";
                text = "File Explorer";
                text_align = "center";
              }
            ];
            persist_buffer_sort = true;
            right_trunc_marker = "";
            separator_style = [
              "|"
              "|"
            ];
            show_buffer_close_icons = true;
            show_buffer_icons = true;
            show_close_icon = true;
            show_tab_indicators = true;
            sort_by = {
              __raw = ''
                function(buffer_a, buffer_b)
                    local modified_a = vim.fn.getftime(buffer_a.path)
                    local modified_b = vim.fn.getftime(buffer_b.path)
                    return modified_a > modified_b
                end
              '';
            };
            tab_size = 18;
          };
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      lazygit.enable = true;

      fidget.enable = true;

      lsp-lines.enable = true;

      comment.enable = true;

      cursorline.enable = true;

      dropbar.enable = true;

      gitblame.enable = true;

      intellitab.enable = true;

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
