{
  pkgs,
  self,
  config,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  # Limit number of snapshots to keep
  boot.loader.systemd-boot.configurationLimit = 20;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;

    # Taken from bazzite
    "vm.max_map_count" = 2147483642;
    "kernel.split_lock_mitigate" = 0;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_mtu_probing" = 1;
    "fs.inotify.max_user_instances" = 8192;
    "fs.inotify.max_user_watches" = 524288;
  };

  boot.resumeDevice = "/dev/disk/by-partlabel/root";
  # FIXME: Change if drive chages or anything
  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Manually_specify_hibernate_location
  # boot.kernelParams = ["resume_offset=23279616"];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   ryzen-smu
  # ];

  hardware.cpu.amd.ryzen-smu.enable = true;
  # https://nixos.wiki/wiki/Linux_kernel
}
