{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "desktop";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    plasma.enable = mkEnableOption "KDE plasma and SDDM";
    gnome.enable = mkEnableOption "Gnome";
  };

  config = mkIf cfg.plasma.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";
    environment.systemPackages = with pkgs; [
      kdePackages.yakuake
      kdePackages.kate
      xorg.libxcb # Too lazy to find another spot (this is for PixelFlasher)
    ];

    programs.kdeconnect.enable = true;
    security.polkit.enable = true;

    # TODO Move this out of here (it is almost midnight)
    services.xserver.desktopManager.gnome.enable = cfg.gnome.enable;
  };
}
