{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.nixvim.plugins = {
      direnv.enable = true;

      #### Treesitter stuff ########
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
        # I don't want them all installed
        # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        #   bash
        #   c
        #   c_sharp
        #   cpp
        #   css
        #   gitattributes
        #   gitcommit
        #   gitignore
        #   go
        #   gomod
        #   gosum
        #   html
        #   javascript
        #   json
        #   jsonc
        #   lua
        #   markdown
        #   nix
        #   php
        #   python
        #   regex
        #   rust
        #   typescript
        #   vim
        #   vimdoc
        #   xml
        #   yaml
        # ];
        # folding = true;
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 4;
          multiline_threshold = 5;
        };
      };

      ts-autotag.enable = true;

      ############################

      #### Code writing QoL #######

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
            "<C-k>" = ["show_signature" "hide_signature" "fallback"];
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

      conform-nvim = {
        enable = true;
        settings = {
          formatters = {
            qmlformat = {
              command = "qmlformat";
              args = config.lib.nixvim.mkRaw ''{"$FILENAME"}'';
            };
          };
          formatters_by_ft = let
            prettier = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              timeout_ms = 2000;
              stop_after_first = true;
            };
          in {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            cpp = ["clang_format"];
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
            html = prettier;
            json = prettier;
            xml = prettier;
            javascript = prettier;
            typescript = prettier;
            typescriptreact = prettier;
            rust = [
              "rustfmt"
            ];
            qml = [
              "qmlformat"
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

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      lsp-lines.enable = true;

      cursorline.enable = true;

      indent-blankline.enable = true;

      guess-indent.enable = true;

      nix.enable = true;

      dropbar.enable = true;

      ###############################

      #### Neovim random utilies ####

      auto-save.enable = true;

      barbar.enable = true;

      multicursors.enable = true;

      comment.enable = true;

      fidget.enable = true;

      lightline.enable = true;

      which-key.enable = true;

      neoclip.enable = true;

      toggleterm = {
        enable = true;
        settings.open_mapping = "[[<C-`>]]";
      };

      # auto-session.enable = true;

      nvim-ufo.enable = true;

      web-devicons.enable = true;

      orgmode.enable = true;
      headlines.enable = true;

      ##############################

      ##### Git and file stuff #######

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

      lazygit.enable = true;

      # gitblame.enable = true;

      neo-tree.enable = true;

      gitsigns.enable = true;

      ###############################
    };
  };
}
