{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    targets.kde.enable = false;
    targets.qt.enable = false;
    targets.firefox = {
      profileNames = ["default"];
    };
    targets.floorp = config.stylix.targets.firefox;

    image = ./wall.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";
  };

  fonts.fontconfig.enable = lib.mkForce false;
}
