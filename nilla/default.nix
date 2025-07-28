{
  config,
  lib,
}: {
  options.mods = lib.options.create {
    type = lib.types.raw;
    default.value = {};
    description = ''
      Shortnames for inputs, pretty much
    '';
  };

  config.mods = {
    disko = config.inputs.disko.result;
    home-manager = config.inputs.home-manager.result;
    hyprland = config.inputs.hyprland.result;
    lix-module = config.inputs.lix-module.result;
    niri = config.inputs.niri.result;
    nix-index-db = config.inputs.nix-index-db.result;
    nixos-hardware = config.inputs.nixos-hardware.result;
    nixvim = config.inputs.nixvim.result;
    plasma-manager = config.inputs.plasma-manager.result;
    sops-nix = config.inputs.sops-nix.result;
    stylix = config.inputs.stylix.result;
  };

  includes = [
    ./homes
    ./packages
    ./systems

    ./inputs.nix
  ];
}
