{
  pkgs,
  self,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  # Limit number of snapshots to keep
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # boot.resumeDevice = "/dev/disk/by-partlabel/root";
  # # FIXME: Change if drive chages or anything
  # # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Manually_specify_hibernate_location
  # # boot.kernelParams = ["resume_offset=23279616"];

  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 8 * 1024;
  #   }
  # ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # https://nixos.wiki/wiki/Linux_kernel
}
