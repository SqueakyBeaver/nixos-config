{ config, pkgs, ... }:
{
  imports = [
    ./programs
    ./services
  ];


  programs.home-manager.enable = true;

  # FIXME: put your own stuff here
  home.username = "beaver";
  home.homeDirectory = "/home/beaver";

  # Probably don't change this
  home.stateVersion = "24.05";
 }
