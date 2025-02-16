{
  services = {
    logind.powerKey = "poweroff";

    thermald = {
      enable = true;
      ignoreCpuidCheck = true;
    };
    thinkfan.enable = true;

    upower.enable = true;
    # nix-hardware enables tlp and I don't want it to >:(
    tlp.enable = false;

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
