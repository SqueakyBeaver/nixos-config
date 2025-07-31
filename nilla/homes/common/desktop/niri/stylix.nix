{
  lib,
  pkgs,
  config,
  ...
}: {
  stylix = {
    targets.kde.enable = lib.mkForce true;
    targets.qt.enable = lib.mkForce true;
    

    fonts.sizes = {
      applications = 12;
      desktop = 11;
      popups = 13;
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
