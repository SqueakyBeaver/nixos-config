{ pkgs, self, ... }:
{
  imports = [
    ./fuzzel
    ./wayland

    ./cli.nix
    ./misc-programs.nix
    ./programming.nix
    ./transient-services.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
