{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "bottles";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install bottles
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bottles
    ];
  };
}
