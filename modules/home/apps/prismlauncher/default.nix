{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "prismlauncher";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install prism launcher
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.prismlauncher
    ];
  };
}
