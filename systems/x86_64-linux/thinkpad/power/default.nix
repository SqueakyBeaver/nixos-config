{pkgs, ...}: {
  services = {
    logind.powerKey = "poweroff";

    thinkfan = {
      enable = true;
      smartSupport = true;
    };

    upower.enable = true;

    thermald = {
      enable = true;
    };

    # nixos-hardware is mean to me ;-;
    tlp.enable = pkgs.lib.mkForce false;

    # Just in case kde plasma enables it
    power-profiles-daemon.enable = false;
  };

  powerManagement.powertop.enable = true;

  environment.systemPackages = [
    pkgs.lm_sensors # For thinkfan
    pkgs.amdctl
  ];

  programs.auto-cpufreq = {
    enable = true;

    settings = {
      charger = {
        governor = "performance";
        platform_profile = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "schedutil";
        platform_profile = "low-power";
        turbo = "never";
        scaling_min_freq = 400000000;
        scaling_max_freq = 2100000000;
      };
    };
  };

  boot.kernelParams = [
    "amd_pstate=active"
    "amd_pstate.shared_mem=1"
  ];

  boot.extraModprobeConfig = ''
    options iwlmvm power_scheme=3
    options iwlwifi power_save=1
  '';

  # For amdctl
  hardware.cpu.x86.msr.enable = true;
}
