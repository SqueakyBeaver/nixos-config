{config, pkgs, ...}: {
  imports = [
    ../common/editors/vscode.nix
    ../common/editors/nvim
  ];

  home.packages = [
    # pkgs.unityhub
    # pkgs.android-studio
  ];
}
