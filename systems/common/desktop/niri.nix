{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
    # ../stylix.nix
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

    gnupg.agent.pinentryPackage = pkgs.pinentry-qt;
    kde-pim.enable = true;
    ssh.askPassword = "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  };

  services = {
    # cage.enable = true;
    displayManager = {
      plasma-login-manager.enable = true;
      defaultSession = "niri";
    };

    udisks2.enable = true;
    blueman.enable = true;
    accounts-daemon.enable = true;
  };

  security.pam.services = {
    login.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
    kde = {
      allowNullPassword = true;
      kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
      };
      # "kde" must not have fingerprint authentication otherwise it can block password login.
      # See https://github.com/NixOS/nixpkgs/issues/239770 and https://invent.kde.org/plasma/kscreenlocker/-/merge_requests/163.
      fprintAuth = false;
      p11Auth = false;
    };
    kde-fingerprint = lib.mkIf config.services.fprintd.enable {
      fprintAuth = true;
      p11Auth = false;
    };
    kde-smartcard = lib.mkIf config.security.pam.p11.enable {
      p11Auth = true;
      fprintAuth = false;
    };
  };

  # qt.platformTheme = "kde";

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.kdePackages.kwallet
    ];
    configPackages = lib.mkDefault [pkgs.kdePackages.plasma-workspace];

    # config = {
    #   niri = {
    #     default = [
    #       "kde"
    #       "gnome"
    #       "gtk"
    #     ];
    #
    #     "org.freedesktop.impl.portal.Access" = "gtk";
    #     "org.freedesktop.impl.portal.FileChooser" = ["kde" "gtk"];
    #     "org.freedesktop.impl.portal.Notification" = "gtk";
    #     "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    #   };
    # };
  };

  # Some nice packages to have
  environment.systemPackages = with pkgs;
    [
      wl-clipboard
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
    ++ (with pkgs.kdePackages; [
      ark
      baloo
      baloo-widgets
      dolphin
      dolphin-plugins
      elisa
      gwenview
      kate
      okular
      ktexteditor
      plasma-browser-integration
      qttools

      # Most likely needed:
      kde-gtk-config
      kio
      kio-admin
      kio-extras
      kio-fuse
      kwallet
      kwallet-pam
      kwalletmanager
      plasma-integration
      kservice # For kbuildsycoca6
      qt6ct
      kded
      breeze
      breeze-icons
      breeze-gtk
      pkgs.hicolor-icon-theme # fallback icons
      kconfig
      qtbase
      frameworkintegration
      polkit-kde-agent-1

      # Might be needed:
      kcoreaddons
      kcolorscheme
      kguiaddons
      kfilemetadata
      kiconthemes
      kimageformats
      kmenuedit
      qtimageformats
      pkgs.xdg-user-dirs

      plasma-workspace # To fix all sorts of issues and stuff

      # Probably not needed:
      kauth
      qqc2-breeze-style
      qqc2-desktop-style
    ]);
}
