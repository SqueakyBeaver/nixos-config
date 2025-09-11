{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    miktex
  ];

  programs = {
    rclone.enable = true; 
  };

  sops.age.keyFile = "/home/beaver/.config/sops/age/keys.txt";
}
