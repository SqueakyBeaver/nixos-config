{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    protontricks
    prismlauncher
    gamescope

    # kdePackages.kdeconnect-kde
    gimp
    krita
    weylus
    inkscape
    vesktop
    vlc
    bitwarden
    blueberry
    networkmanagerapplet
    android-tools

    gtksourceview
    zim
    gtkspell3
    xdot
    graphviz

    # gsettings-qt
    # gsettings-desktop-schemas
    # xdg-desktop-portal-shana
  ];

}
