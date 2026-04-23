{
  lib,
  pkgs,
  config,
  ...
}: {
  stylix = {
    targets.kde.enable = lib.mkForce true;
    targets.qt.enable = lib.mkForce true;

    fonts.sizes = {
      applications = 12;
      desktop = 11;
      popups = 13;
    };
  };

  gtk = {
    # gtk3.theme = {
    #   package = lib.mkForce pkgs.adw-gtk3;
    #   name = lib.mkForce "adw-gtk3-dark";
    # };
    # gtk4.theme = lib.mkForce {
    #   package = lib.mkForce pkgs.gnome-themes-extra;
    #   name = lib.mkForce "Adwaita-dark";
    # };
    # theme = {
    #   package = lib.mkForce pkgs.gnome-themes-extra;
    #   name = lib.mkForce "Adwaita-dark";
    # };
  };
}
