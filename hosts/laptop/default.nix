{ pkgs, self, inputs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "toaster-oven-of-death";
}
