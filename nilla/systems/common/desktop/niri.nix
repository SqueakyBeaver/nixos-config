{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    regreet.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };
    seahorse.enable = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };
    gnome-disks.enable = true;
    file-roller.enable = true;
  };

  services = {
    # cage.enable = true;
    greetd.enable = true;
    gvfs.enable = true;

    udisks2.enable = true;
    udev.packages = [pkgs.swayosd];
    gnome.sushi.enable = true;
    blueman.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    autoEnable = true;
    polarity = "dark";

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };

  xdg.portal = {
    # These *might* not be necessary 
    # but holy shit unityhub is making me lose my fucking mind
    extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

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
    swayosd
    adwaita-icon-theme # For gnome apps
  ];

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
    documentation = ["https://github.com/ErikReider/SwayOSD"];
    wantedBy = ["graphical.target"];
    partOf = ["graphical.target"];
    after = ["graphical.target"];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };
}
