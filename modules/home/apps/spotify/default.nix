{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "spotify";
  cfg = config.${module};
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
      # TODO: use spotX overlay
      pkgs.spotify
    ];
  };
}
