{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  home.packages = [
    pkgs.bitwarden-desktop
    pkgs.inkscape
    pkgs.kdePackages.elisa
    pkgs.libreoffice-stable
    pkgs.motrix
    pkgs.pavucontrol
    pkgs.pixelflasher
    pkgs.scrcpy
    pkgs.vesktop
    pkgs.vlc
    pkgs.pear-desktop
    pkgs.kdePackages.ghostwriter
    pkgs.apktool
    pkgs.jadx
  ];

  programs = {
    aria2.enable = true;

    firefox = {
      enable = true;
    };

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
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
  };
}
