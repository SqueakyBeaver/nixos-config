{config, pkgs, ...}: {
  imports = [
    ../common/editors/vscode.nix
    ../common/editors/nvim
  ];

  home.packages = [
    # I wish I could use godot, but noooooo
    # My professor likes unity
    # I don't.
    pkgs.unityhub
    # pkgs.android-studio
  ];
}
