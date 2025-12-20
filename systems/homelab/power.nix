{pkgs, ...}: {
  services = {
    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # CPU_MIN_PERF_ON_AC = 0;
        # CPU_MAX_PERF_ON_AC = 100;
        # CPU_MIN_PERF_ON_BAT = 0;
        # CPU_MAX_PERF_ON_BAT = 60;

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 2;

        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 80;

        USB_EXCLUDE_BTUSB = 1;
      };
    };

    logind.settings.Login.HandleLidSwitch = "ignore";

    # Just in case kde plasma enables it
    power-profiles-daemon.enable = false;

    # logind.powerKey = "suspend-then-hibernate";
    # logind.lidSwitch = "suspend-then-hibernate";
  };
}
