{ pkgs, self, ... }:
{
  imports = [
    ./core
    ./network
    ./programs
    ./services
  ];
}
