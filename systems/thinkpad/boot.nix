{
  pkgs,
  self,
  config,
  ...
}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # Limit number of snapshots to keep
        configurationLimit = 20;
      };

      efi.canTouchEfiVariables = true;
    };
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;
      };
      sysfs = {
        power = {
          hibernate_compression_threads = 12;
        };
      };
    };

    resumeDevice = "/dev/disk/by-partlabel/root";
    # FIXME: Change if drive chages or anything
    # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Manually_specify_hibernate_location
    kernelParams = ["resume_offset=113192960"];

    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [
      ryzen-smu
    ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
  };

  systemd.oomd = {
    enable = true;
  };
}
