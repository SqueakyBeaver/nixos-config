{
  pkgs,
  config,
  ...
}: {
  config.stylix = {
    enable = true;
    autoEnable = true;
    targets.kde.enable = false;

    image = ./wall.png;

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
    };
  };
}
