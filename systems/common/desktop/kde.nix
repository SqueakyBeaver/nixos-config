{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs.kdePackages; [
    kate
    discover
    karousel
    kfind
    oxygen
    oxygen-icons
    kio-gdrive
    kaccounts-providers
    kaccounts-integration
  ] ++ [
      pkgs.adwaita-icon-theme # For gnome apps
    ];

  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
        enableQt5Integration = true;
      };
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
