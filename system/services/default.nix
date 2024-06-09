{ config, pkgs, ... }:
{
  imports = [
    ./flatpak.nix
    ./greetd.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    # ./sddm.nix
  ];

}
