{pkgs, ...}: {
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
          html = [
            "prettierd"
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

    nix.enable = true;

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
      settings.open_mapping = "[[<C-\\>]]";
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

    auto-session.enable = true;

    nvim-ufo.enable = true;

    web-devicons.enable = true;

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

    gitblame.enable = true;

    neo-tree.enable = true;

    gitsigns.enable = true;


    ###############################
  };

  programs.nixvim.extraPlugins = [
    # TODO: Other jujutsu plugins (am tired)
    (pkgs.vimUtils.buildVimPlugin {
      name = "jj-diffconflicts";
      src = pkgs.fetchFromGitHub {
        owner = "rafikdraoui";
        repo = "jj-diffconflicts";
        hash = "sha256-LM2eP29yK+lIlWzJiIKIRcbVjNhyjV2unE4GJDTLKXQ=";
        rev = "8140e5295ef2008a947f1f374c2d71a5bc7e38a0";
      };
    })
    pkgs.vimPlugins.vim-dirdiff
  ];

  home.packages = [
    # https://github.com/jj-vcs/jj/wiki/Vim#dirdiff-plugin
    (pkgs.writeShellScriptBin "nvimdirdiff" ''
      DIR1=$(printf '%q' "$1"); shift
      DIR2=$(printf '%q' "$1"); shift
      # Setting the colorscheme is optional
      nvim "$@" -c "DirDiff $DIR1 $DIR2"
    '')
  ];
}
