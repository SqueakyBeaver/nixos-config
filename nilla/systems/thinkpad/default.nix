{
  config,
  lib,
}: let
  inherit (config) mods;
in {
  config = {
    systems.nixos.thinkpad = {
      args = {
        project = config;
      };

      modules = [
        # I put everything in a seperate dir to make it look nicer
        ./sysconfig/configuration.nix
        ../common
        ../common/desktop/kde.nix
        mods.chaotic.nixosModules.default
        mods.lix-module.nixosModules.lixFromNixpkgs
        mods.niri.nixosModules.niri
        mods.sops-nix.nixosModules.sops
        mods.stylix.nixosModules.stylix
        mods.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
        mods.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
        }
      ];

      homes = {inherit (config.homes) "beaver:x86_64-linux";};
    };
  };
}
