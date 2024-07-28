{
  pkgs,
  inputs,
  ...
}: let
  # TODO: make it system agnostic or whatever
  vscode-extensions = inputs.nix-vscode-extensions.extensions.x86_64-linux;
in {
  programs.vscode = {
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
      # "lldb.library" = "${pkgs.lldb.lib}/lib/liblldb.so";
    };
  };
}
