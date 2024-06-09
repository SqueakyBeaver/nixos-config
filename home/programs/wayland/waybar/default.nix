{ inputs, pkgs, ... }:
{
  programs.waybar = {
    enable = true;

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
          format = "{useage}%  {max_frequency}";
        };

        "custom/dunst" = {
          "exec" = ./dunst.sh; 
          "on-click" = "dunstctl set-paused toggle";
          "restart-interval" = 1;
        };
      };
    };
  };
}
