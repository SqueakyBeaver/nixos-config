{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    targets.firefox = {
      profileNames = ["default"];
    };
    targets.gtk.extraCss = ''
      window.background { border-radius: 2px; }
    '';

    image = ./wall.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";
  };

  # fonts.fontconfig.enable = lib.mkForce false;
}
