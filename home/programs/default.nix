{ pkgs, self, ... }:
{
  imports = [
    ./fuzzel
    ./wayland

    ./cli.nix
    ./gui.nix
    ./misc-programs.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
