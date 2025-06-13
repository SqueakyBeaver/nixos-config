{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "vlc";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install VLC
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.vlc
    ];
  };
}
