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

    image = ./wall.png;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";

    polarity = "dark";

    icons = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };
  };

  # fonts.fontconfig.enable = lib.mkForce false;
}
