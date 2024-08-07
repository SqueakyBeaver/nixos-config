{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./backlight.nix
    ./flatpak.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    ./sddm.nix
    ./tailscale.nix 
  ];

  # MySQL (Mariadb)
  # I'm not gonna make a new file right now unless I need to
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}
