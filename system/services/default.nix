{ config, pkgs, ... }:
{
  imports = [
    ./flatpak.nix
    ./gnome.nix
    ./greetd.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    # ./sddm.nix
  ];

}
