{
  config,
  pkgs,
  project,
  ...
}: {
  home.packages = [
    # project.packages.musescore-appimage.result.${pkgs.system}
    # pkgs.muse-sounds-manager
    pkgs.bitwarden
    (pkgs.bottles.override {removeWarningPopup = true;})

    pkgs.vesktop
    # pkgs.dolphin-emu
    # pkgs.gimp
    pkgs.hedgemodmanager
    pkgs.libreoffice-fresh
    # pkgs.prismlauncher
    pkgs.pavucontrol
    # pkgs.spotify
    pkgs.youtube-music
    pkgs.kdePackages.elisa
    pkgs.vlc

    pkgs.xournalpp
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };

  programs.floorp = {
    enable = true;
    package = pkgs.firedragon;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
    ];
  };
}
