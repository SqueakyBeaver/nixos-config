{ pkgs, self, ... }: {
  # Tell electron apps to use wayland (hope)
  environment.variables.NIXOS_OZONE_WL = "1";

  # enable hyprland and required options
  programs.hyprland.enable = true;

  services.hyperidle.enable = true;

  programs.hyprlock.enable = true;

  qt = {
    enable = true;
    #  TODO: Theme maybe
  };
}
