{ inputs, config, self, ... }:
{
  imports = [
    ./ags
    ./media
    ./system
    ./wayland
  ];


  theme = {
    wallpaper = /. + "${config.xdg.userDirs.pictures}" /wall;
  };

  programs. matugen = {
    enable = false;
    wallpaper = self.theme.wallpaper;
  };
}
