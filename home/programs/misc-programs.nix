{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    protontricks
    prismlauncher

    # kdePackages.kdeconnect-kde
    gimp
    inkscape
    vesktop
    vlc
    bitwarden
  ];
}