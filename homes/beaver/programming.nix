{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    llvmPackages.clang
    shellcheck
    go
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
    tree-sitter
  ];
}
