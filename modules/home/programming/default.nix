{pkgs, namespace, ...}: {
  home.packages = with pkgs; [
    #LSP/Linters/Etc
    nil
    alejandra
    # nodePackages.eslint

    # Languages
    # corepack_22
    # go
    # python312
    # rustc
    # cargo
    # nodejs

    openssl
  ];

}
