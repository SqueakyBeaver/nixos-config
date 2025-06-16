{config, pkgs, ...}: {
  imports = [
    ../common/editors/vscode.nix
    ../common/editors/nvim
  ];
}
