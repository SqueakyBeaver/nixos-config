{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    adwaita-qt
  ];

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      # package = pkgs.catppuccin-qt5ct;
      # name = "Catppuccin";
      name = "adwaita-dark";
    };
  };
}
