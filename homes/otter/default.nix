{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./apps.nix
    ./editors.nix
    ../common/desktop/plasma
    ../common
    inputs.nix-index-db.homeModules.nix-index
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ### OOOOH Java font anti-aliasing
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    # For neovim-remote
    # NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
  };

  home.username = "otter";
  home.homeDirectory = "/home/otter";
  home.stateVersion = "24.05";
}
