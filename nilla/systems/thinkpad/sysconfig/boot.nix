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
  };

  boot.resumeDevice = "/dev/disk/by-partlabel/root";
  # FIXME: Change if drive chages or anything
  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Manually_specify_hibernate_location
  boot.kernelParams = ["resume_offset=113192960"];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    ryzen-smu
  ];
}
