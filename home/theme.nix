{
  config,
  self,
  ...
}: {
  theme = {
    wallpaper = let
      # FIXME: Change to main branch later possibly
      url = "https://github.com/SqueakyBeaver/nixos-config/blob/hyprland/home/wall.png?raw=true";
      sha256 = "f425039150f02ffb31bf376182ab2ed85e359eb61c4c7c61549fdf671768f54f";
      ext = "png";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };

  programs. matugen = {
    enable = false;
    wallpaper = config.theme.wallpaper;
  };
}
