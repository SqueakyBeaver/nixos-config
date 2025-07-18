{
  config,
  pkgs,
  project,
  ...
}: {
  imports = [
    ../common/editors/vscode.nix
    ../common/editors/nvim
    ../common/editors/emacs
  ];

  home.packages = [
    # I wish I could use godot, but noooooo
    # My professor likes unity
    # I don't.
    # AAAA JUST MERGE NIXPKGS PR#422785
    project.packages.unityhub.result.${pkgs.system}
    # pkgs.unityhub
    # pkgs.android-studio
  ];
}
