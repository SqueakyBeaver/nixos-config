{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "musescore";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkEnableOption "Whether to install musescore";
    sounds.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install the musescore sounds installer
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.musescore-appimage
      (mkIf cfg.sounds.enable pkgs.muse-sounds-manager)
    ];
  };
}
