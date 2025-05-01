{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "fluffychat";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install fluffychat, a matrix client built with flutter
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.fluffychat
    ];
  };
}
