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
    corepack_22
    go
    python312
    poetry
    rustc
    cargo
    nodejs

    openssl
    nodePackages.prisma
    prisma-engines

    react-native-debugger
  ];
}
