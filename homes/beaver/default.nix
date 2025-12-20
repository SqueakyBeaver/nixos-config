{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./apps.nix
    ./cli.nix
    ./editors.nix
    ./programming.nix
    ./syncthing
    ../common
    ../common/stylix.nix
    ../common/desktop/plasma
    inputs.nixvim.homeModules.nixvim
    inputs.nix-index-db.homeModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ### OOOOH Java font anti-aliasing
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    # For neovim-remote
    # NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
    EDITOR = "nvim";
  };

  home.username = "beaver";
  home.homeDirectory = "/home/beaver";
  home.stateVersion = "24.05";
}
