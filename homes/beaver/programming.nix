{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    llvmPackages.clang
    csharpier
    dotnet-sdk_9
    omnisharp-roslyn
    mono
    shellcheck
    go
    gopls
    nodejs
    typescript
    prettier
    prettierd
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
