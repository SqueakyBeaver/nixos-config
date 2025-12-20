{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./lsp.nix
    ./maps.nix
    ./plugins.nix
  ];

  home.packages = [
    pkgs.wl-clipboard
    pkgs.neovim-remote
    pkgs.neovim-qt
  ];

  programs = {
    neovide = {
      enable = true;
    };

    nixvim = {
      enable = true;
      # Not good to enable this, but I hate compiling nil
      nixpkgs.useGlobalPackages = true;

      clipboard.providers.wl-copy.enable = true;
      clipboard.register = "unnamedplus";
      luaLoader.enable = true; # Why not

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
        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
      };

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
    };
  };
}
