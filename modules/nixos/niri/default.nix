{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  module = "desktop";
  cfg = config.${module};
in {
  options.${module} = {
    niri.enable = mkEnableOption "Use the niri compositor";
  };

  config = mkIf cfg.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    services.xserver.displayManager.gdm = {
      enable = true;
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      autoEnable = true;
      targets.plymouth.enable = false;

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };
    };

    programs.kdeconnect = {
      enable = true;
      # package = pkgs.gnomeExtensions.gsconnect;
    };

    programs.seahorse.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    services.gvfs.enable = true;
    programs.file-roller.enable = true;

    # Some nice packages to have
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      gamescope
      xwayland-satellite-unstable
      swaybg
      networkmanagerapplet
      swaylock
      swayidle
    ];
  };
}
