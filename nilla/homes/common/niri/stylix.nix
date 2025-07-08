{
  lib,
  pkgs,
  config,
  ...
}: {
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
