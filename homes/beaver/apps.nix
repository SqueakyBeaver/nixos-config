{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    # project.packages.musescore-appimage.result.${pkgs.system}
    # pkgs.muse-sounds-manager
    pkgs.bitwarden-desktop
    (pkgs.bottles.override {removeWarningPopup = true;})
    pkgs.hedgemodmanager
    pkgs.inkscape
    pkgs.kdePackages.elisa
    pkgs.libreoffice-fresh
    pkgs.motrix
    pkgs.pavucontrol
    pkgs.pixelflasher
    pkgs.vesktop
    pkgs.vlc
    pkgs.youtube-music
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
