{ config, pkgs, ... }:
{
  imports = [
    ./flatpak.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    ./sddm.nix
  ];

}
