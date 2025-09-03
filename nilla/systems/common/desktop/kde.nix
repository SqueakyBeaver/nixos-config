{
  config,
  pkgs,
  lib,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.discover
    kdePackages.karousel
    adwaita-icon-theme # For gnome apps
    xsettingsd # Unity is a piece of shit
  ];

  qt.platformTheme = lib.mkForce "kde";
  stylix.targets.qt.platform = "kde6";

  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  security.polkit.enable = true;

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
