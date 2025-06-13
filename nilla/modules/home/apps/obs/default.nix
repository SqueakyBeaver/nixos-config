{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "obs";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install obs";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
      ];
    };
  };
}
