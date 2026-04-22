{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.bitwarden-desktop
    (pkgs.bottles.override {removeWarningPopup = true;})
    pkgs.inkscape
    pkgs.kdePackages.elisa
    pkgs.libreoffice-fresh
    pkgs.motrix
    pkgs.musescore
    pkgs.muse-sounds-manager
    pkgs.pavucontrol
    pkgs.pixelflasher
    pkgs.scrcpy
    pkgs.vesktop
    pkgs.vlc
    pkgs.pear-desktop
  ];

  programs = {
    aria2.enable = true;

    firefox = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
      ];
    };

    floorp = {
      enable = true;
      package = null;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
      ];
    };

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
      ];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
      ];
    };
  };
}
