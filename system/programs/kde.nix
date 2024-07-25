{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
}
