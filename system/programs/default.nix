{ pkgs, self, ... }:
{
  imports = [
    ./fonts.nix
    ./games.nix
    ./home-manager.nix
    ./hyprland.nix
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };
}
