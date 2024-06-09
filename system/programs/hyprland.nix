{ pkgs, self, ... }: {
  # Tell electron apps to use wayland (hope)
  environment.variables.NIXOS_OZONE_WL = "1";

  # enable hyprland and required options
  programs.hyprland.enable = true;

  # May not be necessary but oh well
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  qt = {
    enable = true;
    style = "breeze";
  };
}
