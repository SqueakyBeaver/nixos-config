{ config, pkgs, ... }:
{
  imports = [
    ./backlight.nix
    ./flatpak.nix
    # ./gnome.nix
    # ./greetd.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    ./sddm.nix
  ];

}
