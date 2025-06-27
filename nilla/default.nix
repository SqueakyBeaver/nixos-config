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
    lix-module = config.inputs.lix-module.result;
    niri = config.inputs.niri.result;
    stylix = config.inputs.stylix.result;
    home-manager = config.inputs.home-manager.result;
    nixos-hardware = config.inputs.nixos-hardware.result;
    sops-nix = config.inputs.sops-nix.result;
    nix-index-db = config.inputs.nix-index-db.result;
    nixvim = config.inputs.nixvim.result;
  };

  includes = [
    ./homes
    ./packages
    ./systems

    ./inputs.nix
  ];
}
