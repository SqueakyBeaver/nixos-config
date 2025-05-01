{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "vlc";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install VLC
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vlc
    ];
  };
}
