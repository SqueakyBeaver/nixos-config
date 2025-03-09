{
  config,
  lib,
  namespace,
  inputs,
  system,
  pkgs,
  ...
}:
with lib; let
  module = "editors";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Enable graphical editors/IDEs";
    codium.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable VSCodium
      '';
    };

    android.enable = mkOption {
      type = types.bool;
      default = false; # It's very heavy and I only sometimes use it
      description = ''
        Enable Android Studio
      '';
    };

    pragtical.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable pragtical ediro
      '';
    };

    nvim.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable neovim using the LazyVim configuration
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = let
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
    in
      mkIf cfg.codium.enable {
        enable = true;
        # package = pkgs.vscodium;
        extensions = with vscode-extensions;
        with pkgs.vscode-extensions;
          [
            open-vsx.rust-lang.rust-analyzer
            open-vsx.mkhl.direnv
            open-vsx.jnoortheen.nix-ide
            open-vsx.tamasfe.even-better-toml
            open-vsx.serayuzgur.crates
            open-vsx.pkief.material-icon-theme
            open-vsx.eamodio.gitlens
          ]
          ++ [
            # pkgs.vscode-extensions
            # For those extensions that  don't work on the vscode-extensions repo
            vadimcn.vscode-lldb
            ms-python.python
            ms-python.debugpy
            ms-python.isort
            ms-python.vscode-pylance
            ms-python.black-formatter
            visualstudioexptteam.vscodeintellicode
            yzhang.markdown-all-in-one
            shd101wyy.markdown-preview-enhanced
            llvm-vs-code-extensions.vscode-clangd
            ms-vscode.cpptools-extension-pack
            redhat.java
            ms-toolsai.jupyter
            ms-toolsai.jupyter-renderers
            ms-toolsai.datawrangler
          ];

        userSettings = {
          "workbench.colorTheme" = "Default Dark+";
          "editor.fontFamily" = "Fira Code";
          "files.autoSave" = "afterDelay";
          "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
          "editor.fontLigatures" = true;
          "editor.minimap.enabled" = false;
          "editor.formatOnSave" = true;
          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = "alejandra";
          "rust-analyzer.debug.openDebugPane" = true;
          "workbench.iconTheme" = "material-icon-theme";
          "nix.serverSettings" = {
            "nil" = {
              "diagnostics" = {
                "ignored" = ["unused_binding" "unused_with"];
              };
              "formatting" = {
                "command" = ["alejandra"];
              };
            };
          };
          # "python.languageServer" = "Jedi";
          "gitlens.telemetry.enabled" = false;
          "telemetry.telemetryLevel" = "off";
          "leetcode.workspaceFolder" = "/home/beaver/Coding/leetcode";
          "leetcode.defaultLanguage" = "python3";
          "leetcode.hint.commandShortcut" = false;
          "leetcode.hint.setDefaultLanguage" = false;
          "leetcode.hint.configWebviewMarkdown" = false;
          "leetcode.showDescription" = "Both";
        };
      };

    home.packages = [
      (mkIf cfg.android.enable pkgs.android-studio)
      (mkIf cfg.pragtical.enable pkgs.pragtical)
      # (mkIf cfg.nvim.enable pkgs.lunarvim)
    ];

    programs.neovim = mkIf cfg.nvim.enable {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        LazyVim
        lazy-nvim

      ];
    };
  };
}
