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
  };

  config = mkIf cfg.enable {
    programs.vscode = let
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
    in
      mkIf cfg.codium.enable {
        enable = true;
        # package = pkgs.vscodium;
        extensions = with vscode-extensions;
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
            # For those extensions that  don't work on the vscode-extensions repo
            pkgs.vscode-extensions.vadimcn.vscode-lldb
            pkgs.vscode-extensions.ms-python.python
            pkgs.vscode-extensions.ms-python.debugpy
            # pkgs.vscode-extensions.ms-python.isort
            pkgs.vscode-extensions.ms-python.vscode-pylance
            pkgs.vscode-extensions.ms-python.black-formatter
            pkgs.vscode-extensions.yzhang.markdown-all-in-one
            pkgs.vscode-extensions.shd101wyy.markdown-preview-enhanced
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
        };
      };

    home.packages = mkIf cfg.android.enable [
      pkgs.android-studio
    ];
  };
}
