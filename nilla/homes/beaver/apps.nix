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
    pkgs.vkbasalt
    pkgs.winetricks
    # I have problems with a specific game and I'm hoping this will fix them
    pkgs.wine-staging
    pkgs.vkd3d

    pkgs.legcord
    # pkgs.dolphin-emu
    # pkgs.gimp
    project.inputs.hmm.result.packages.${pkgs.system}.default
    pkgs.libreoffice-fresh
    pkgs.obsidian
    # pkgs.prismlauncher
    pkgs.spotify
    pkgs.vlc
    pkgs.umu-launcher

    # hopefully makes the global app menu work
    pkgs.libdbusmenu
    pkgs.libsForQt5.libdbusmenu

    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-vaapi
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
    policies."3rdparty" = {
      Extensions = {
        "uBlock0@raymondhill.net" = {
          adminSettings = {
            # I like ironfox's uBlock default filters better
            assetsBootstrapLocation = "https://gitlab.com/ironfox-oss/IronFox/-/raw/dev/uBlock/assets.main.json";
          };
        };
      };
    };
  };

  programs.floorp = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.valent
    ];
    policies = config.programs.firefox.policies;
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
