{pkgs, ...}: {
  services = {
    thinkfan = {
      enable = true;
      smartSupport = true;

      levels = [
        [0 0 55]
        [1 50 65]
        [3 60 75]
        [5 70 85]
        [7 85 32767]
      ];
    };

    upower.enable = true;

    tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_SCALING_GOVERNOR_ON_SAV = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balanced";
        CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        PLATFORM_PROFILE_ON_SAV = "low-power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
        CPU_BOOST_ON_SAV = 0;

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 2;

        RADEON_DPM_PERF_LEVEL_ON_AC = "high";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";

        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "balanced";

        USB_EXCLUDE_BTUSB = 1;
      };
    };

    power-profiles-daemon.enable = false;
  };

  boot.kernelParams = [
    "amd_pstate=guided"
  ];

  environment.systemPackages = [
    pkgs.lm_sensors # For thinkfan
  ];
}
