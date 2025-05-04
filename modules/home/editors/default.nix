{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  module = "editors";
  cfg = config.${module};
in {
  imports = [
    ./nixvim
  ];

  options.${module} = {
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

    nvim.enable = mkEnableOption "Neovim";

    unity.enable = mkEnableOption "Unity hub/game engine thingy";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
    };
    # programs.vscode = let
    #   vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
    # in
    #   mkIf cfg.codium.enable {
    #     enableExtensionUpdateCheck = false;
    #     enableUpdateCheck = false;
    #     enable = true;
    #     # package = pkgs.vscodium;
    #     profiles.default = {
    #       extensions = with vscode-extensions;
    #       with pkgs.vscode-extensions;
    #         [
    #           open-vsx.rust-lang.rust-analyzer
    #           open-vsx.mkhl.direnv
    #           open-vsx.jnoortheen.nix-ide
    #           open-vsx.tamasfe.even-better-toml
    #           open-vsx.serayuzgur.crates
    #           open-vsx.pkief.material-icon-theme
    #           open-vsx.eamodio.gitlens
    #         ]
    #         ++ [
    #           # nixpkgs vscode-extensions
    #           # For those extensions that  don't work on the other vscode-extensions repo
    #           vadimcn.vscode-lldb
    #           ms-python.python
    #           ms-python.debugpy
    #           ms-python.isort
    #           ms-python.vscode-pylance
    #           ms-python.black-formatter
    #           visualstudioexptteam.vscodeintellicode
    #           yzhang.markdown-all-in-one
    #           shd101wyy.markdown-preview-enhanced
    #           llvm-vs-code-extensions.vscode-clangd
    #           ms-vscode.cpptools-extension-pack
    #           ms-toolsai.jupyter
    #           ms-toolsai.jupyter-renderers
    #           ms-toolsai.datawrangler
    #           ms-vscode-remote.remote-ssh
    #           ms-vscode-remote.remote-ssh-edit
    #         ];

    #       userSettings = {
    #         "workbench.colorTheme" = "Default Dark+";
    #         "editor.fontFamily" = "Fira Code";
    #         "files.autoSave" = "afterDelay";
    #         "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    #         "editor.fontLigatures" = true;
    #         "editor.minimap.enabled" = false;
    #         "editor.formatOnSave" = true;
    #         "nix.enableLanguageServer" = true;
    #         "nix.formatterPath" = "alejandra";
    #         "rust-analyzer.debug.openDebugPane" = true;
    #         "workbench.iconTheme" = "material-icon-theme";
    #         "nix.serverSettings" = {
    #           "nil" = {
    #             "diagnostics" = {
    #               "ignored" = ["unused_binding" "unused_with"];
    #             };
    #             "formatting" = {
    #               "command" = ["alejandra"];
    #             };
    #           };
    #         };
    #         # "python.languageServer" = "Jedi";
    #         "gitlens.telemetry.enabled" = false;
    #         "telemetry.telemetryLevel" = "off";
    #         "leetcode.workspaceFolder" = "/home/beaver/Coding/leetcode";
    #         "leetcode.defaultLanguage" = "python3";
    #         "leetcode.hint.commandShortcut" = false;
    #         "leetcode.hint.setDefaultLanguage" = false;
    #         "leetcode.hint.configWebviewMarkdown" = false;
    #         "leetcode.showDescription" = "Both";
    #       };
    #     };
    #   };

    # programs.nvchad = mkIf cfg.nvchad.enable {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     basedpyright
    #     python3
    #   ];

    #   extraPlugins = ''
    #     return {
    #       { "direnv/direnv.vim", lazy = false }
    #     }
    #   '';

    #   extraConfig = ''
    #     require'lspconfig'.basedpyright.setup{}
    #     require'lspconfig'.ruff.setup{}
    #     require'lspconfig'.rust_analyzer.setup{}
    #     require'lspconfig'.clangd.setup{}
    #     require'lspconfig'.nil_ls.setup{}
    #   '';

    #   hm-activation = true;
    #   # backup = true;
    # };

    programs.nixvim = mkIf cfg.nvim.enable {
      enable = true;
    };

    home.packages = [
      (mkIf cfg.android.enable pkgs.android-studio)
      (mkIf cfg.nvim.enable pkgs.wl-clipboard)
      (mkIf cfg.nvim.enable pkgs.neovim-remote)
      (mkIf cfg.nvim.enable pkgs.neovim-qt)
      (mkIf cfg.unity.enable pkgs.unityhub)
    ];
  };
}
