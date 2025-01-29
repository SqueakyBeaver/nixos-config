{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  module = "xdg";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkEnableOption "XDG portals module";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["kde" "gtk" "gnome"];
      };

      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
