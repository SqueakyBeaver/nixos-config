{ inputs, self, ... }:
{
  imports = [
    ./programs
    ./services
    ./theme.nix
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    self.nixosModules.theme

  ];


  programs.home-manager.enable = true;

  # FIXME: put your own stuff here
  home = {
    username = "beaver";
    homeDirectory = "/home/beaver";

    # Probably don't change this
    stateVersion = "24.05";
  };
}
