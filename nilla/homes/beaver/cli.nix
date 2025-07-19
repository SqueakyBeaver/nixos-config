{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    miktex
  ];

  sops.age.keyFile = "/home/beaver/.config/sops/age/keys.txt";
}
