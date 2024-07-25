{
  pkgs,
  self,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Limit number of snapshots to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernel.sysctl."kernel.sysrq" = 1;
}
