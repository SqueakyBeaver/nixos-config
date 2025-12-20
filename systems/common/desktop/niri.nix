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
    gnome.sushi.enable = true;
    blueman.enable = true;
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
    kdePackages.dolphin
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
    # GTK themes pls work
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
    gnome-themes-extra
  ];
}
