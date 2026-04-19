# Niri config for me :3
{pkgs, ...}: {
  imports = [
    ./binds.nix
    ../noctalia
  ];

  qt.platformTheme.name = "qtct";

  services = {
    cliphist.enable = true;
  };

  programs = {
    alacritty.enable = true;

    niri = {
      package = pkgs.niri-unstable;
      settings = {
        clipboard.disable-primary = true;
        prefer-no-csd = true;

        spawn-at-startup = [
          {argv = ["noctalia-shell"];}
        ];

        environment = {
          QT_QPA_PLATFORM = "wayland";
          QT_QPA_PLATFORMTHEME = "qt6ct";
          DISPLAY = ":0";
          NIXOS_OZONE_WL = "1";
        };

        cursor = {
          theme = "breeze_cursors";
        };

        input = {
          power-key-handling.enable = false;
          keyboard = {
            xkb = {
              layout = "us";
              options = "caps:backspace";
            };
          };

          touchpad = {
            accel-profile = "flat";
            accel-speed = 0.50;
            click-method = "clickfinger";
            scroll-method = "two-finger";
          };

          mouse = {
            accel-profile = "flat";
            accel-speed = 0.20;
          };

          trackpoint = {
            accel-profile = "flat";
            accel-speed = 0.20;
          };
        };

        layout = {
          preset-column-widths = [
            {proportion = 1. / 3.;}
            {proportion = 1. / 2.;}
            {proportion = 2. / 3.;}
          ];

          tab-indicator = {
            gap = 4;
            place-within-column = true;
            corner-radius = 5;
            gaps-between-tabs = 5;
          };

          border = {
            enable = false;
          };

          focus-ring = {
            width = 2;
          };

          gaps = 5;
        };

        workspaces = {
          main = {};
          music = {};
        };

        layer-rules = [
          {
            matches = [
              {namespace = "bar";}
              {namespace = "wallpaper";}
            ];
            block-out-from = "screencast";
          }
          {
            excludes = [
              {namespace = "bar$";}
              {namespace = "wallpaper";}
              {namespace = "notif";}
              {namespace = "noctalia";}
            ];

            geometry-corner-radius = let
              r = 7.0;
            in {
              top-left = r;
              top-right = r;
              bottom-right = r;
              bottom-left = r;
            };
            shadow.enable = true;
          }
          {
            matches = [{namespace = "^noctalia-overview*";}];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            draw-border-with-background = false;
            geometry-corner-radius = let
              r = 7.0;
            in {
              top-left = r;
              top-right = r;
              bottom-right = r;
              bottom-left = r;
            };

            clip-to-geometry = true;
          }
          {
            matches = [
              {
                app-id = "steam";
                title = "^notificationtoasts_\\d+_desktop$";
              }
            ];
            default-floating-position = {
              relative-to = "bottom-right";
              x = 10;
              y = 10;
            };
            open-floating = true;
          }
        ];

        debug = {
          # For noctalia notification actions and window activation
          honor-xdg-activation-with-invalid-serial = true;
        };
      };
    };
  };
}
