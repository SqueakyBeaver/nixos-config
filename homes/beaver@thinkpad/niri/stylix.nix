{
  lib,
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    targets.kde.enable = false;
    targets.nixvim = {
      transparentBackground = {
        main = true;
        numberLine = true;
        signColumn = true;
      };
    };

    image = ./wall.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";

    opacity.terminal = .85;

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
    };
  };
  systemd.user.services."swaybg" = {
    Unit = {
      Description = "wallpapers! brought to you by stylix! :3";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${config.stylix.image}";
      Restart = "on-failure";
    };
  };
}
