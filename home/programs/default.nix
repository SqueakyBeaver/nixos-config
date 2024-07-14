{ pkgs, self, ... }:
{
  imports = [
    # ./neovim #Temporarily unused

    ./cli.nix
    ./direnv.nix
    ./games.nix
    ./helix.nix
    ./misc-programs.nix
    ./programming.nix
    ./term.nix
    ./transient-services.nix
    ./zsh.nix
  ];
}
