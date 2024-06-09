{ pkgs, self, inputs, lib, ... }: let
in {
  imports = [
    ./hardware-configuration.nix

    
  ];

  networking.hostName = "toaster-oven-of-death";
}
