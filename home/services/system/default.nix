{ pkgs, self, ... }:
{
  imports = [
    ./cliphist.nix
    ./kdeconnect.nix
    ./polkit.nix
  ];
}
