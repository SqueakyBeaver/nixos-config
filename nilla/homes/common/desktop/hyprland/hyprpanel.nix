{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.matugen
  ];

  programs.hyprpanel = {
    enable = true;

    settings = {
      wallpaper.image = "${config.stylix.image}";
      theme = {
        matugen = true;
        font.size = "1rem";
      };
      scalingPriority = "hyprland";
    };
  };
}
