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

  boot.kernelPackages = pkgs.cachyosKernels.linux-cachyos-latest-x86_64-v3;
  # https://nixos.wiki/wiki/Linux_kernel
}
