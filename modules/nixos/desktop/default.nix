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
      kdePackages.discover
      kdePackages.karousel
      material-kwin-decoration
      adwaita-icon-theme # For gnome apps
    ];

    services.input-remapper.enable = true;

    # programs.partition-manager.enable = true;
    programs.kdeconnect.enable = true;
    security.polkit.enable = true;

    programs.dconf.enable = true;
    # TODO Move this out of here so it doesn't rely on plasma being enabled (it is almost midnight)
    services.xserver.desktopManager.gnome.enable = cfg.gnome.enable;
  };
}
