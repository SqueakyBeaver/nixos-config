{ pkgs, self, ... }:
{
  imports = [
    ./fuzzel
    ./wayland
    ./zsh.nix
  ];
}
