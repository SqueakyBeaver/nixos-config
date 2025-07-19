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
    project.inputs.hmm.result.packages.${pkgs.system}.default
    pkgs.libreoffice-fresh
    # pkgs.prismlauncher
    pkgs.spotify
    pkgs.vlc
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
