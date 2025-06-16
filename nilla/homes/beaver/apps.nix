{
  config,
  pkgs,
  project,
  ...
}: {
  home.packages = with pkgs; [
    project.packages.musescore-appimage.result.${pkgs.system}
    pkgs.muse-sounds-manager
    pkgs.bitwarden
    pkgs.bottles
    pkgs.legcord
    # pkgs.dolphin-emu
    # pkgs.gimp
    project.inputs.hmm.result.packages.${pkgs.system}.default
    pkgs.libreoffice-fresh
    pkgs.obsidian
    pkgs.prismlauncher
    pkgs.spotify
    pkgs.vlc
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
      pkgs.valent
      pkgs.gnomeExtensions.gsconnect
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
