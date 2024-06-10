{ pkgs, self, ... }:
{
  imports = [
    ./fonts.nix
    ./games.nix
    ./home-manager.nix
    ./hyprland.nix
    ./xdg.nix
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;

  };
}
