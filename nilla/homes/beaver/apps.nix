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

    pkgs.legcord
    # pkgs.dolphin-emu
    # pkgs.gimp
    pkgs.hedgemodmanager
    pkgs.libreoffice-fresh
    # pkgs.prismlauncher
    pkgs.spotify
    pkgs.vlc
  ];

  programs.firefox = {
    enable = true;
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
