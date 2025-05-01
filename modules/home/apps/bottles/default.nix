{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "bottles";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install bottles
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bottles
    ];
  };
}
