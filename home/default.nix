{  lib, self, inputs, ... }:
{
  imports = [
    ./programs
    ./services
    ./theme.nix
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    ../modules/theme
  ];

  # FIXME: put your own stuff here
  home = {
    username = "beaver";
    # homeDirectory = /home/beaver;

    # Probably don't change this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
