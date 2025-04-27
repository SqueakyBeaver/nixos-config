{
  pkgs,
  config,
  ...
}: {
  config.stylix = {
    enable = true;
    targets.kde.enable = false;

    image = pkgs.fetchurl {
      url = "https://sonic.sega.jp/SonicChannel/upload_images/wallpaper_243_knuckles_19_pc.png";
      hash = "sha256-Yt1q9ynzmlGI21/Suhl4Ik4iXbvPlwb+YjdluIyt898=";
    };

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
    };
  };
}
