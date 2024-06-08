{ pkgs, self, ... }:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl."kernel.sysrq" = 1;
  };
}
