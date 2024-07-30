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
  appName = "graphics";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install graphics (drawing, etc.) programs
      '';
    };

    gimp.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install gimp
      '';
    };

    krita.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install krita
      '';
    };

    inkscape.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install inkscape
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf cfg.${appName}.enable [
      mkIf
      cfg.${appName}.gimp.enable
      pkgs.gimp
      mkIf
      cfg.${appName}.krita.enable
      pkgs.krita
      mkIf
      cfg.${appName}.inkscape.enable
      pkgs.inkscape
    ];
  };
}
