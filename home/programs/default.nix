{ pkgs, self, ... }:
{
  imports = [
    ./anyrun
    ./fuzzel
    ./wayland

    ./cli.nix
    ./gtk.nix
    ./misc-programs.nix
    ./programming.nix
    ./term.nix
    ./transient-services.nix
    ./zsh.nix
  ];
}
