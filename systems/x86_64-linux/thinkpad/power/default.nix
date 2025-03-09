{pkgs, ...}: {
  services = {
    logind.powerKey = "poweroff";

    thinkfan = {
      enable = true;

      smartSupport = true;

      # Text wall incoming
      sensors = [
        {
          query = "/proc/acpi/ibm/thermal";
          type = "tpacpi";
        }
        # I guess sometimes the hwmon number changes. interesting.
        {
          query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon6/temp6_input";
          type = "hwmon";
        }
        {
          query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon6/temp3_input";
          type = "hwmon";
        }
        {
          query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon6/temp7_input";
          type = "hwmon";
        }
        {
          query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon6/temp4_input";
          type = "hwmon";
        }
        # CPU
        {
          query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon6/temp1_input";
          type = "hwmon";
        }
        # NVME sensors
        {
          query = "/sys/devices/pci0000:00/0000:00:02.1/0000:01:00.0/nvme/nvme0/hwmon1/temp3_input";
          type = "hwmon";
        }
        {
          query = "/sys/devices/pci0000:00/0000:00:02.1/0000:01:00.0/nvme/nvme0/hwmon1/temp1_input";
          type = "hwmon";
        }
        {
          query = "/sys/devices/pci0000:00/0000:00:02.1/0000:01:00.0/nvme/nvme0/hwmon1/temp2_input";
          type = "hwmon";
        }
        # GPU
        {
          query = "/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.0/hwmon/hwmon0/temp1_input";
          type = "hwmon";
        }
        # CPU
        {
          query = "/sys/devices/virtual/thermal/thermal_zone0/hwmon2/temp1_input";
          type = "hwmon";
        }
        # Wifi card
        {
          query = "/sys/devices/virtual/thermal/thermal_zone1/hwmon7/temp1_input";
          type = "hwmon";
        }
      ];

      levels = [
        [0 0 50]
        [1 47 60]
        [3 57 70]
        [4 67 80]
        ["level full-speed" 77 32767]
      ];
    };

    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # CPU_MIN_PERF_ON_AC = 0;
        # CPU_MAX_PERF_ON_AC = 100;
        # CPU_MIN_PERF_ON_BAT = 0;
        # CPU_MAX_PERF_ON_BAT = 60;

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 3;

        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 80;

        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        USB_EXCLUDE_BTUSB = 1;
      };
    };

    # Just in case kde plasma enables it
    power-profiles-daemon.enable = false;
  };

  environment.systemPackages = [
    pkgs.lm_sensors # For thinkfan
  ];
}
