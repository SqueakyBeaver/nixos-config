{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "prismlauncher";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install prism launcher
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.prismlauncher
    ];
  };
}
