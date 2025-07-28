{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./apps.nix
    ./editors.nix
    ../common/stylix.nix
    ../common/desktop/plasma
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
