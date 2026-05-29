{
pkgs,
  ...
}: {
  imports = [
    ../common/editors/vscode.nix
    ../common/editors/nvim
    ../common/editors/emacs
  ];

  home.packages = with pkgs; [
    android-studio
  ];
}
