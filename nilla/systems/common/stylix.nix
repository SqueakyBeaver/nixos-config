{
  pkgs,
  lib,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    autoEnable = true;
    polarity = "dark";

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };
}
