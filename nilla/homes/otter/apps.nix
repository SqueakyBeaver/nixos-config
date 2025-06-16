{
  config,
  pkgs,
  project,
  ...
}: {
  home.packages = with pkgs; [
    pkgs.bitwarden
    pkgs.obsidian
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
}
