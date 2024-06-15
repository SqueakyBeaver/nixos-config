{ pkgs, self, ... }:
{
  imports = [
    ./anyrun
    ./fuzzel
    ./wayland

    ./cli.nix
    ./games.nix
    ./gtk.nix
    ./misc-programs.nix
    ./neovim.nix
    ./programming.nix
    ./term.nix
    ./transient-services.nix
    ./zsh.nix
  ];
}
