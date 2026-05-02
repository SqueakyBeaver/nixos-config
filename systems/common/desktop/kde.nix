{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.discover
    kdePackages.karousel
    kdePackages.kfind
    kdePackages.oxygen
    kdePackages.oxygen-icons
    adwaita-icon-theme # For gnome apps
  ];

  services = {
    desktopManager = {
      plasma6.enable = true;
    };

    displayManager = {
      plasma-login-manager.enable = true;
      defaultSession = "plasma";
    };
  };

  programs = {
    partition-manager.enable = true;
    kdeconnect.enable = true;
    dconf.enable = true;
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
