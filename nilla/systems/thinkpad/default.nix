{
  config,
  lib,
}: {
  config = {
    systems.nixos.thinkpad = {
      args = {
        project = config;
      };

      modules = with config.modules; [
        ../../modules/nixos

        ./configuration.nix

        sops-nix.nixosModules.sops
        niri.nixosModules.niri
        stylix.nixosModules.stylix

        home-manager.nixosModules.home-manager
        # WARNING: IF YOU DON'T HAVE THIS BIT, EVERYTHING WILL EXPLODE
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
        }

        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
      ];

      homes = {
        "beaver@thinkpad" = {
          systems = ["x86_64-linux"];

          args = {
            project = config;
          };

          modules = with config.modules; [
            ../../homes/beaver

            sops-nix.homeManagerModules.sops
            nixvim.homeManagerModules.nixvim
            nix-index-db.hmModules.nix-index

            ../../modules/home
          ];
        };
      };
    };
  };
}
