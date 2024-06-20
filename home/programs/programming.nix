{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Text editors or IDEs
    vscode
    # neovim
    android-studio # Commented until I need it

    #LSP/Linters/Etc
    nil
    nixpkgs-fmt
    nodePackages.eslint

    # Languages
    go
    python312
    rustc
    cargo
    nodejs
  ];
}
