{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "musescore";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install musescore";
    };
    sounds.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install the musescore sounds installer
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.musescore-appimage
      (lib.mkIf cfg.sounds.enable pkgs.muse-sounds-manager)
    ];
  };
}
