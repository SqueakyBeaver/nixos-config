{
  services = {
    logind.powerKey = "poweroff";

    thermald.enable = true;

    upower.enable = true;

    # Just in case kde plasma enables it
    power-profiles-daemon.enable = false;
  };

  programs.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "never";
        };
      };
    };
}
