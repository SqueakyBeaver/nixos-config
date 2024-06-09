{ pkgs, lib, config, ... }:
{
  theme = {
    wallpaper = /. + "${config.xdg.userDirs.pictures}" /wall;
  };

  programs. matugen = {
    enable = false;
    wallpaper = config.theme.wallpaper;
  };

}
