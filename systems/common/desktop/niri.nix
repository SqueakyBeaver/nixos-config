{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    regreet.enable = true;
    kdeconnect = {
      enable = true;
    };
    seahorse.enable = true;
  };

  services = {
    # cage.enable = true;
    greetd.enable = true;

    udisks2.enable = true;
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
  environment.systemPackages = with pkgs;
    [
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
    ]
    ++ (with pkgs.kdePackages; [
      ark
      baloo
      baloo-widgets
      dolphin
      dolphin-plugins
      elisa
      gwenview
      kate
      kde-gtk-config
      kio
      kio-admin
      kio-extras
      kio-fuse
      ktexteditor
      kwallet
      kwallet-pam
      kwalletmanager
      okular
    ]);
}
