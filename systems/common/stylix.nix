{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    autoEnable = true;
    polarity = "dark";

    targets = {
      gtksourceview.enable = false;
    };

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };
}
