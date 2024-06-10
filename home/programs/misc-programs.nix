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
  ];
}
