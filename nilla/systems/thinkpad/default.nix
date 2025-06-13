{
  config,
  lib,
}: {
  # includes = [
  #   ./configuration.nix
  #   ./hardware-configuration.nix
  # ];

  config = {
    systems.nixos.thinkpad = {
      modules = with config.modules; [
        ../../modules/nixos

        ./configuration.nix

        sops-nix.nixosModules.sops
        niri.nixosModules.niri
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
      ];

      homes = {
        "beaver@thinkpad" = {
          systems = ["x86_64-linux"];

          modules = [
            (import ../../homes/beaver config.inputs)

            ../../modules/home
          ];
        };
      };
    };
  };
}
