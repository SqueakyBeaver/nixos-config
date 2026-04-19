{
  pkgs,
  inputs,
  lib,
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
    kdeconnect = {
      enable = true;
    };
    seahorse.enable = true;
    dconf.enable = true;
  };

  services = {
    # cage.enable = true;
    displayManager = {
      plasma-login-manager.enable = true;
      defaultSession = "niri";
    };

    udisks2.enable = true;
    blueman.enable = true;
  };

  qt.platformTheme = "qt6ct";

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = lib.mkDefault [pkgs.kdePackages.plasma-workspace];

    config = {
      niri = {
        default = [
          "kde"
          "gnome"
          "gtk"
        ];

        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = ["kde" "gtk"];
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };
  };

  # Some nice packages to have
  environment.systemPackages = with pkgs;
    [
      wl-clipboard
      kdePackages.dolphin
      wayland-utils
      libsecret
      gamescope
      xwayland-satellite-unstable
      networkmanagerapplet
      swaylock
      nautilus
      # GTK themes pls work
      adwaita-icon-theme
      gnome-icon-theme
      hicolor-icon-theme
      gnome-themes-extra
      xdg-user-dirs-gtk
    ]
    # ++ (with pkgs.kdePackages; [
    #   ark
    #   baloo
    #   baloo-widgets
    #   dolphin
    #   dolphin-plugins
    #   elisa
    #   gwenview
    #   kate
    #   kde-gtk-config
    #   kio
    #   kio-admin
    #   kio-extras
    #   kio-fuse
    #   ktexteditor
    #   kwallet
    #   kwallet-pam
    #   kwalletmanager
    #   okular
    #
    #   plasma-workspace
    #
    #   kconfig
    #   qtbase
    #   frameworkintegration
    #   kauth
    #   kcoreaddons
    #   kded
    #   kfilemetadata
    #   kguiaddons
    #   kiconthemes
    #   kimageformats
    #   plasma-workspace
    #   qt6ct
    #   qtimageformats
    #   libplasma
    #   plasma-integration
    #   breeze
    #   breeze-icons
    #   breeze-gtk
    #   pkgs.hicolor-icon-theme # fallback icons
    #   qqc2-breeze-style
    #   qqc2-desktop-style
    #   pkgs.xdg-user-dirs
    #   kservice
    # ]);
}
