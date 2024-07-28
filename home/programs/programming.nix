{pkgs, ...}: {
  home.packages = with pkgs; [
    # Text editors or IDEs
    # neovim
    android-studio # Commented until I need it
    zed-editor

    #LSP/Linters/Etc
    nil
    alejandra
    nodePackages.eslint
    lldb

    # Languages
    corepack_22
    go
    python312
    poetry
    rustc
    cargo
    rust-analyzer
    nodejs

    openssl
    nodePackages.prisma
    prisma-engines

    react-native-debugger
  ];
}
