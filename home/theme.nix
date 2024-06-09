{ config, self, ... }:
{
  theme = {
    wallpaper = "${toString ./wall.png}";
  };
 
  programs. matugen = {
    enable = false;
    wallpaper = config.theme.wallpaper;
  };
}
