{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "spotify";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install spotify
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.spotify
    ];
  };
}
