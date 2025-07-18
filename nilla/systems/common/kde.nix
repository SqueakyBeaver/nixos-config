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

  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # autoEnable = false;
    polarity = "dark";
    # targets.plymouth.enable = false;
    # targets.qt.enable = false;

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.discover
    kdePackages.karousel
    material-kwin-decoration
    adwaita-icon-theme # For gnome apps
  ];

  services.input-remapper.enable = true;

  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  security.polkit.enable = true;

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
