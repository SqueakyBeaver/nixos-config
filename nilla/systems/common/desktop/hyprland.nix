{
  config,
  lib,
  pkgs,
  project,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    autoEnable = true;
    polarity = "dark";

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };

  programs = {
    hyprland = {
      enable = true;
      # withUWSM = true;
    };

    regreet.enable = true;

    kdeconnect = {
      enable = true;
    };

    seahorse.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = [
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.gwenview
    pkgs.kdePackages.okular
    pkgs.kdePackages.elisa
    pkgs.kdePackages.kate
    pkgs.adwaita-icon-theme
    pkgs.libsecret
  ];

  qt.enable = true;
}
