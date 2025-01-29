{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "vesktop";
  cfg = config.${module};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install vesktop
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vesktop
    ];
  };
}
