{ pkgs, self, ... }:
{
  imports = [
    ./fuzzel
    ./wayland

    ./cli.nix
    ./misc-programs.nix
    ./programming.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
