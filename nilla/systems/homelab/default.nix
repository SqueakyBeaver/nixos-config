{
  config,
  lib,
}: let
  inherit (config) mods;
in {
  config = {
    systems.nixos.homelab = {
      args = {
        project = config;
      };

      modules = [
        # I put everything in a seperate dir to make it look nicer
        ./sysconfig/configuration.nix

        ../common
        ../common/desktop/kde.nix
        mods.disko.nixosModules.default
        mods.lix-module.nixosModules.lixFromNixpkgs
        # mods.niri.nixosModules.niri
        mods.sops-nix.nixosModules.sops
        mods.stylix.nixosModules.stylix

        mods.home-manager.nixosModules.home-manager
        # WARNING: IF YOU DON'T HAVE THIS BIT, EVERYTHING WILL EXPLODE
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
        }

        mods.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
      ];

      homes = {inherit (config.homes) "otter:x86_64-linux";};
    };
  };
}
