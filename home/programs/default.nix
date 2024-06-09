{ pkgs, self, ... }:
{
  imports = [
    ./fuzzel
    ./wayland

    ./cli.nix
    ./misc-programs.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
