{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "musescore";
  cfg = config.${namespace}.${module}.${appName};
in {
  options.${namespace}.${module}.${appName} = {
    enable = mkEnableOption "Whether to install musescore";
    sounds.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install the musescore sounds installer
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      # pkgs.musescore
      # temporary fix bc panels are broken atm
      pkgs.${namespace}.musescore-appimage
      (mkIf cfg.sounds.enable pkgs.muse-sounds-manager)
    ];
  };
}
