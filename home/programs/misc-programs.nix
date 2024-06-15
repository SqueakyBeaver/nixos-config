{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    protontricks
    prismlauncher
    gamescope

    # kdePackages.kdeconnect-kde
    gimp
    inkscape
    vesktop
    vlc
    bitwarden
    blueberry
    networkmanagerapplet
    android-tools

    # gsettings-qt
    # gsettings-desktop-schemas
    # xdg-desktop-portal-shana
  ];

}
