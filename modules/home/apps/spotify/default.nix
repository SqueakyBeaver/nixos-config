{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "spotify";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install spotify
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.spotify
    ];
  };
}
