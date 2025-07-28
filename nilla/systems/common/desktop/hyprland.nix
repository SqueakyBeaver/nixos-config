{
  config,
  lib,
  pkgs,
  project,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.desktop.environment;
in lib.mkIf (cfg == "hyprland") {
  programs.hyprland = {
    enable = true;

    package = project.mods.hyprland.${system}.hyprland;
    portalPackage = project.mods.hyprland.${system}.xdg-desktop-portal-hyprland;
  };
}
