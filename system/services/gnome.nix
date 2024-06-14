{ pkgs, ... }: {
  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome.gnome-settings-daemon
    ];

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
  };
  programs.dconf.enable = true;
  services.xserver.desktopManager.gnome.enable = true; # Need this for a minute
}
