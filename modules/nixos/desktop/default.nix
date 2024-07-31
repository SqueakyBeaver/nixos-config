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
    ];

    programs.kdeconnect.enable = true;
  };
}
