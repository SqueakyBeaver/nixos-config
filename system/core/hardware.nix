{ config, pkgs, ... }:
{
  imports = [
    # FIXME: Add your own hardware-configuration.nix
    ../hardware-configuration.nix
  ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
