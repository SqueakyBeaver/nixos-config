{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "xdg";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "XDG portals module";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}
