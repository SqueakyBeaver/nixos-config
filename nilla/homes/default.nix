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
        config.mods.nixvim.homeManagerModules.nixvim
        config.mods.nix-index-db.homeModules.nix-index
        config.mods.plasma-manager.homeManagerModules.plasma-manager
        config.mods.sops-nix.homeManagerModules.sops
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
        config.mods.nixvim.homeManagerModules.nixvim
        config.mods.nix-index-db.homeModules.nix-index
        config.mods.plasma-manager.homeManagerModules.plasma-manager
      ];

      args = {
        project = config;
        system = "x86_64-linux";
      };
    };
  };
}
