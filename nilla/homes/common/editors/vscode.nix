{
  config,
  pkgs,
  ...
}: {
  config.programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        pkief.material-icon-theme
        mkhl.direnv
        ms-python.python
        ms-python.debugpy
        ms-python.isort
        ms-python.vscode-pylance
        ms-python.black-formatter
        visualstudioexptteam.vscodeintellicode
        yzhang.markdown-all-in-one
        llvm-vs-code-extensions.vscode-clangd
        ms-vscode.cpptools-extension-pack
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-toolsai.datawrangler
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.remote-containers
        ms-azuretools.vscode-docker
        editorconfig.editorconfig
        github.codespaces
        ms-vsliveshare.vsliveshare
        mads-hartmann.bash-ide-vscode
      ];

      userSettings = {
        editor.bracketPairColorization.independentColorPoolPerBracketType = true;
        editor.fontFamily = "Fira Code";
        editor.fontLigatures = true;
        editor.minimap.enabled = false;
        files.autoSave = "afterDelay";
        nix.enableLanguageServer = true;
        nix.formatterPath = "alejandra";
        nix.serverSettings.nil = {
          diagnostics.ignored = [
            "unused_binding"
            "unused_with"
          ];
          formatting.command = [
            "alejandra"
          ];
        };
        telemetry.telemetryLevel = "off";
        workbench.iconTheme = "material-icon-theme";
        mesonbuild.downloadLanguageServer = true;
        cpp = {
          editor.defaultFormatter = "llvm-vs-code-extensions.vscode-clangd";
          editor.inlineSuggest.syntaxHighlightingEnabled = true;
          editor.fontFamily = "'Fira Code Retina', 'monospace', monospace";
        };
        direnv.restart.automatic = true;
        mesonbuild.formatting.enabled = true;
        github.copilot.enable = {
          "*" = false;
          plaintext = false;
          markdown = false;
          scminput = false;
        };
        terminal.external.linuxExec = "zsh";
        terminal.integrated.cursorBlinking = true;
        terminal.integrated.defaultProfile.linux = "zsh";
        terminal.integrated.enableVisualBell = true;
        terminal.integrated.enableImages = true;
        terminal.integrated.smoothScrolling = true;
        liveshare.publishWorkspaceInfo = true;
        lldb.verboseLogging = true;
        makefile.configureOnOpen = true;
        C_Cpp.intelliSenseEngine = "disabled";
        C_Cpp.doxygen.generatedStyle = "/**";
        C_Cpp.inlayHints.autoDeclarationTypes.showOnLeft = true;
        C_Cpp.inlayHints.parameterNames.enabled = true;
        C_Cpp.inlayHints.referenceOperator.enabled = true;
        doxdocgen.generic.briefTemplate = "";
        editor.cursorSmoothCaretAnimation = "on";
        diffEditor.ignoreTrimWhitespace = false;
        basedpyright.analysis.typeCheckingMode = "standard";
        python.analysis.typeCheckingMode = "standard";
        python.analysis.inlayHints.callArgumentNames = "all";
        python.analysis.inlayHints.functionReturnTypes = true;
        python.analysis.inlayHints.variableTypes = true;
        python.analysis.languageServerMode = "full";
        python.analysis.supportDocstringTemplate = true;
        python.diffEditor.ignoreTrimWhitespace = false;
        extensions.experimental.affinity = {
          "asvetliakov.vscode-neovim" = 1;
        };
        containers.containerClient = "com.microsoft.visualstudio.containers.podman";
        telemetry.feedback.enabled = false;
      };
    };
  };
}
