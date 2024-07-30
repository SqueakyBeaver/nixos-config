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
        package = pkgs.vscodium;
        # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]); # temporary, don't shoot me
        extensions = with vscode-extensions;
          [
            # vscode-marketplace.vadimcn.vscode-lldb
            open-vsx.rust-lang.rust-analyzer
            open-vsx.mkhl.direnv
            open-vsx.jnoortheen.nix-ide
            open-vsx.tamasfe.even-better-toml
            open-vsx.serayuzgur.crates
            open-vsx.pkief.material-icon-theme
            open-vsx.eamodio.gitlens
          ]
          ++ [
            # Only way this actually works, in my testing
            pkgs.vscode-extensions.vadimcn.vscode-lldb
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
        };
      };

    home.packages = mkIf cfg.android.enable [
      pkgs.android-studio
    ];
  };
}
