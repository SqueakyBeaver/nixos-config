{ pkgs, self, ... }:
{
  imports = [
    ./hyprland.nix
    ./games.nix
    ./zsh.nix
  ];
}
