{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Text editors or IDEs
    vscode
    # neovim
    # android-studio # Commented until I need it

    #LSP
    nil
    nixpkgs-fmt

    # Languages
    go
    python312
    rustc
    cargo
    nodejs
  ];
}
