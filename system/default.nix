{ pkgs, ... }:
{
  imports = [
    ./core
    ./network
    ./nix
    ./programs
    ./services
  ];
}
