let
  pins = import ./npins;

  nilla = import pins.nilla;
in
  nilla.create ({config}: {
    includes = [
      ./nilla

      # TODO: look into nilla-nixos.modules.nixos
      "${pins.nilla-nixos}/modules/nixos.nix"
      "${pins.nilla-home}/modules/nixos.nix"
      "${pins.nilla-home}/modules/home.nix"
    ];
  })
