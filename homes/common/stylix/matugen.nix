{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    wallpaper = ../wall.png;
  };
}
