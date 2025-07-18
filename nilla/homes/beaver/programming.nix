{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    clang
    shellcheck
    dotnet-sdk
    go
    gopls
    nodejs
    typescript
    prettier
    stylelint
    discount # Markdown
    pandoc
    alejandra
    nil
    python3
    ruff
    basedpyright
    rustc
    cargo
    rust-analyzer
    rustfmt
    tree-sitter
  ];
}
