{
  pkgs,
  config,
  lib,
  ...
}: {
  config = {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    services = {
      # cage.enable = true;
      greetd.enable = true;
    };

    programs.regreet = {
      enable = true;
    };

    stylix = {
      enable = true;
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      autoEnable = true;
      polarity = "dark";
      # targets.plymouth.enable = false;

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };
    };

    programs.kdeconnect = {
      enable = true;
      package = pkgs.valent;
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

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };

    programs.gnome-disks.enable = true;
    services.udisks2.enable = true;

    services.gnome.sushi.enable = true;
    services.blueman.enable = true;

    # Some nice packages to have
    environment.systemPackages = with pkgs; [
      nautilus
      eog
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
