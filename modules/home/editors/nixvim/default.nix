{pkgs, ...}: {
  programs.nixvim = {
    clipboard.providers.wl-copy.enable = true;

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

    # Todo: Figure out which ones I like
    keymaps = [
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
        action = ''
          function()
              require("conform").format { lsp_fallback = true }
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
        action = ''
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
        action = ''
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
          clangd.enable = true;
          basedpyright.enable = true;
          gopls.enable = true;
          html.enable = true;
          nil_ls.enable = true;
          ruff.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          ts_ls.enable = true;
          cssls.enable = true;
        };
      };

      lsp-status.enable = true;
      lsp-lines.enable = true;

      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "nvim_lsp_document_symbol";}
            {name = "nvim_lsp_signature_help";}
            {name = "buffer";}
            # {name = "cmdline";}
            {name = "async_path";}
            {name = "treesitter";}
          ];
          # completion = {
          #   # I hate it when the completion window shows up on a completely blank line!
          #   keyword_pattern = ''[[\%(-\?\d\+\%(\.\d\+\)\?\|\h\%(\w+\|\%(-\w*\)\+\)\)]]'';
          # };

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  require("intellitab").indent()
                end
              end
            '';
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

      comment.enable = true;

      cursorline.enable = true;

      dropbar.enable = true;

      gitblame.enable = true;

      intellitab.enable = true;

      lightline.enable = true;

      nix.enable = true;

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

      neo-tree.enable = true;

      neoclip.enable = true;

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

      which-key.enable = true;

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
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          default_format_opts.lsp_format = "fallback";
        };
      };

      toggleterm = {
        enable = true;
        settings.open_mapping = "[[<C-\\>]]";
      };

      web-devicons.enable = true;

      gitsigns.enable = true;

      indent-blankline.enable = true;

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
    };
  };
}
