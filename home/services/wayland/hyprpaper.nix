{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  # Set the wallpaper to ~/pictures/wall (or similar path),
  # which is a symlink to a wallpaper image
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${xdg.userDirs.pictures}/wall
    wallpaper = , ${xdg.userDirs.pictures}/wall
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe inputs.hyprpaper.packages.${pkgs.system}.default}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
