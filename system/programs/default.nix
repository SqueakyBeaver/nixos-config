{ pkgs, self, ... }:
{
  imports = [
    ./fonts.nix
    ./games.nix
    ./hyprland.nix
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };
}
