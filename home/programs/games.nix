{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    protontricks
    prismlauncher
    gamescope
  ];
}
