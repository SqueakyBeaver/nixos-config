{
  config,
  pkgs,
  lib,
  ...
}: let
  scaling_factor = 80;
in {
  home.packages = [
    pkgs.matugen
  ];

  programs.hyprpanel = {
    enable = true;

    settings = {
      wallpaper.image = "${config.stylix.image}";

      scalingPriority = "hyprland";

      bar = {
        clock = {
          format = "%d-%b-%Y %H:%M";
        };

        modules = {
          clock = {
            time.military = true;
            weather.enabled = false;
          };

          dashboard = {
            shortcuts.enabled = false;
            directories.enabled = false;
          };
        };

        layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "windowtitle"
              "hypridle"
            ];
            middle = ["clock" "media"];
            right = [
              "systray"
              "volume"
              "network"
              "bluetooth"
              "power"
              "notifications"
            ];
          };
        };
      };

      theme = {
        matugen = true;
        font.size = "1rem";
        font.name = "Inter";

        matugen_settings = {
          scheme_type = "fidelity";
          variation = "standard_2";
        };

        tooltip.scaling = scaling_factor;

        osd = {
          orientation = "horizontal";
          location = "bottom";
        };

        bar = {
          scaling = scaling_factor;
          margin_sides = ".2em";
          margin_top = ".1em";
        };

        menus = {
          popover.scaling = scaling_factor;
          menu = let
            modules = [
              "battery"
              "bluetooth"
              "clock"
              "dashboard"
              "media"
              "network"
              "notifications"
              "power"
              "volume"
            ];
          in
            lib.attrsets.genAttrs modules (name: {scaling = scaling_factor;});
        };
      };
    };
  };
}
