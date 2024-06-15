{ pkgs, self, ... }:
{
  imports = [
    ./anyrun
    ./fuzzel
    ./neovim 
    ./wayland

    ./cli.nix
    ./games.nix
    ./gtk.nix
    ./misc-programs.nix
    ./programming.nix
    ./term.nix
    ./transient-services.nix
    ./zsh.nix
  ];
}
