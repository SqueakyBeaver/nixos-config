{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "pixelflasher";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install PixelFlasher
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.${namespace}.pixelflasher
    ];
  };
}
