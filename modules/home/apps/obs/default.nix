{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "obs";
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
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
      ];
    };
  };
}
