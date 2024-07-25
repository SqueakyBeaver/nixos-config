{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Text editors or IDEs
    # neovim
    android-studio # Commented until I need it
    zed-editor

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
    rust-analyzer
    nodejs

    openssl
    nodePackages.prisma
    prisma-engines

    react-native-debugger
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vadimcn.vscode-lldb
      rust-lang.rust-analyzer
      mkhl.direnv
      jnoortheen.nix-ide
    ];
  };
}
