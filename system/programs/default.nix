{ pkgs, self, ... }:
{
  imports = [
    ./fonts.nix
    ./games.nix
    ./hyprland.nix
  ];
}
