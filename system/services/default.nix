{ config, pkgs, ... }:
{
  imports = [
    ./flatpak.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
  ];

  # I don't feel like making another file right now
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
}
