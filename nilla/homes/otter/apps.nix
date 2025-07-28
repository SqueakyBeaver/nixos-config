{
  config,
  pkgs,
  project,
  ...
}: {
  home.packages = with pkgs; [
    pkgs.bitwarden
    pkgs.vlc
  ];

  programs.firefox = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
