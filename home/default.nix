{ config, pkgs, ... }:
{
  imports = [
    ./programs
    ./services
  ];

  # FIXME: put your own stuff here
  home.username = "beaver";
  home.userDirectory = "/home/beaver";

  programs.home-manager.enable = true;

  # Probably don't change this
  home.stateVersion = "24.05";
 }
