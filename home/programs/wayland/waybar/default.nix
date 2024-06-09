{ inputs, pkgs, self, ... }:
{
  programs.waybar = {
    enable = true;

    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [ "hyprland/workspaces" "hyprland/window" "wlr/taskbar" ];
        modules-center = [ "mpd" "temperature" "memory" "cpu" ];
        modules-right = [ "tray" "backlight" "bluetooth" "network" "clock" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        cpu = {
          format = "{usage}%    {max_frequency}GHz";
        };

        "custom/dunst" = {
          "exec" = "${self}./dunst.sh";
          "on-click" = "dunstctl set-paused toggle";
          "restart-interval" = 1;
        };
      };
    };
  };
}
