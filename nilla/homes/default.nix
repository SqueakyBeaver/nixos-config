{
  config,
  lib,
}: let
in {
  config.homes = {
    "beaver:x86_64-linux" = {
      modules = [
        ./beaver
        ./common
        config.mods.nixvim.homeModules.nixvim
        config.mods.nix-index-db.homeModules.nix-index
        config.mods.sops-nix.homeManagerModules.sops
        config.mods.plasma-manager.homeModules.plasma-manager
      ];

      args = {
        project = config;
        system = "x86_64-linux";
      };
    };
    "otter:x86_64-linux" = {
      modules = [
        ./otter
        ./common
        config.mods.nixvim.homeModules.nixvim
        config.mods.nix-index-db.homeModules.nix-index
        config.mods.plasma-manager.homeModules.plasma-manager
      ];

      args = {
        project = config;
        system = "x86_64-linux";
      };
    };
  };
}
