{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./apps.nix
    ./cli.nix
    # ./syncthing
    ./editors.nix
    # ../common/niri
    ../common/stylix.nix
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
