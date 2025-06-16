{
  config,
  pkgs,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  stylix.enable = false;
  stylix.targets.qt.enable = false;

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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
