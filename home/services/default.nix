{ config, pkgs, self, ... }:
{
  imports = [
    ./ags
    ./media
    ./system
    ./wayland
  ]
}