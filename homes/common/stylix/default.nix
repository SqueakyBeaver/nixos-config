{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./matugen.nix
  ];

  gtk = {
    colorScheme = "dark";

    gtk4.theme = config.gtk.theme;
  };

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      firefox = {
        profileNames = ["default"];
      };
      zen-browser = {
        profileNames = ["default"];
      };
      gtksourceview.enable = false;
    };

    image = lib.mkForce null;
    base16Scheme = lib.mkForce config.theme.colors or "${inputs.tinted-themes}/base24/material-dark.yaml";

    polarity = "dark";

    icons = {
      enable = true;
      package = pkgs.kdePackages.breeze-icons;
      light = "breeze";
      dark = "breeze-dark";
    };
  };

  # fonts.fontconfig.enable = lib.mkForce false;
}
