{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.vlc
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
