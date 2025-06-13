{pkgs, ...}: {
  services = {
    thinkfan = {
      enable = true;
      smartSupport = true;
    };

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

        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        USB_EXCLUDE_BTUSB = 1;
      };
    };

    # Just in case kde plasma enables it
    power-profiles-daemon.enable = false;

    # logind.powerKey = "suspend-then-hibernate";
    # logind.lidSwitch = "suspend-then-hibernate";
  };

  systemd.services.batenergy = {
    description = "Track battery energy change during sleep/suspend";
    wantedBy = ["sleep.target"];

    path = [pkgs.bash pkgs.bc];

    unitConfig = {
      Before = "sleep.target";
      StopWhenUnneeded = "yes";
    };

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${./batenergy.sh} pre";
      ExecStop = "${./batenergy.sh} post";
    };
  };

  # powerManagement.powertop.enable = true;

  environment.systemPackages = [
    pkgs.lm_sensors # For thinkfan
    pkgs.amdctl
    pkgs.bc
  ];
}
