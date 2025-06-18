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
      pkgs.valent
    ];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
