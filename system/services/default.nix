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

  # MySQL (Mariadb)
  # I'm not gonna make a new file right now unless I need to
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}
