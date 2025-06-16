{
  config,
  lib,
}: let
in {
  config.homes."beaver:x86_64-linux" = {
    modules = [
      ./beaver

      config.mods.sops-nix.homeManagerModules.sops
      config.mods.nixvim.homeManagerModules.nixvim
      config.mods.nix-index-db.hmModules.nix-index
    ];

    args = {
      project = config;
      system = "x86_64-linux";
    };
  };
}
