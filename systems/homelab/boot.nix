{
  pkgs,
  self,
  config,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  # # Limit number of snapshots to keep
  boot.loader.systemd-boot.configurationLimit = 20;
  #
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub = {
  #   enable = true;
  #   efiSupport = true;
  #   efiInstallAsRemovable = true;
  # };

  boot.kernel.sysctl."kernel.sysrq" = 1;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # https://nixos.wiki/wiki/Linux_kernel
}
