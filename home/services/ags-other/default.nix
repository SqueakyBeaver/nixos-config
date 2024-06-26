{ inputs, pkgs, lib, config, ... }:
let
  requiredDeps = with pkgs; [
    config.wayland.windowManager.hyprland.package
    bash
    coreutils
    dart-sass
    gawk
    imagemagick
    procps
    ripgrep
    util-linux
    python312Packages.pywayland
    python312Packages.psutil
    hyprpicker
    hypridle
    hyprlock
    anyrun
    ddcutil
    gjs
    gtksourceview
    gtk3
  ];

  guiDeps = with pkgs; [
    gnome.gnome-control-center
    mission-center
    overskride
    wlogout
  ];

  dependencies = requiredDeps ++ guiDeps;

  cfg = config.programs.ags;
in
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = dependencies;

  programs.ags.enable = true;



  # systemd.user.services.ags = {
  #   unitConfig = {
  #     Description = "Aylur's Gtk Shell";
  #     PartOf = [
  #       "tray.target"
  #       "graphical-session.target"
  #     ];
  #   };
  #   serviceConfig = {
  #     Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
  #     ExecStart = "${cfg.package}/bin/ags";
  #     Restart = "on-failure";
  #   };
  #   Install.WantedBy = [ "graphical-session.target" ];
  # };
}
