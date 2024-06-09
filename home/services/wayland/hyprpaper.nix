{ pkgs, inputs, lib, config, ... }: {
  # Set the wallpaper to ~/pictures/wall (or similar path),
  # which is a symlink to a wallpaper image
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.theme.wallpaper}
    wallpaper = , ${config.theme.wallpaper}
  '';
  systemd.user.services.hyprpaper = {
    unitConfig = {
      Description = "Hyprland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };
    serviceConfig = {
      ExecStart = "${lib.getExe inputs.hyprpaper.packages.${pkgs.system}.default}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
