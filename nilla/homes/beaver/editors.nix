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
    (project.packages.unityhub.result.${pkgs.system}.override {
      extraLibs = unityhubPkgs: [
        (unityhubPkgs.runCommand "libxml2-fake-old-abi" {} ''
          mkdir -p "$out/lib"
          ln -s "${unityhubPkgs.lib.getLib unityhubPkgs.libxml2}/lib/libxml2.so" "$out/lib/libxml2.so.2"
        '')
      ];
    })
    # pkgs.unityhub
    # pkgs.android-studio
  ];
  # For unity
  services.xsettingsd.enable = true; 
}
