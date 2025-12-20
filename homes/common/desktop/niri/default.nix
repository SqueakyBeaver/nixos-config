# Niri config for me :3
{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ../waybar
    ./stylix.nix
    ./binds.nix
    ../../stylix.nix
  ];

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    rofimoji
    xsettingsd
    wl-gammarelay-rs
  ];

  services = {
    swaync.enable = true;
    cliphist.enable = true;
    swayosd.enable = true;

    swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          event = "lock";
          command = "lock";
        }
      ];
      timeouts = [
        {
          timeout = 260;
          command = "${pkgs.brightnessctl}/bin/brightnessctl s 50%-";
        }
        {
          timeout = 400;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 600;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };

  # systemd.user.services.swayosd.Service.ExecStart = lib.mkForce (let
  #   cfg = config.services.swayosd;
  # in
  #   "${cfg.package}/bin/swayosd-libinput-backend"
  #   + (lib.optionalString (cfg.display != null) " --display ${cfg.display}")
  #   + (lib.optionalString (cfg.stylePath != null) " --style ${lib.escapeShellArg cfg.stylePath}")
  #   + (lib.optionalString (cfg.topMargin != null) " --top-margin ${toString cfg.topMargin}"));

  programs = {
    fuzzel.enable = true;
    alacritty.enable = true;
    swaylock.enable = true;
    wlogout.enable = true;

    niri = {
      package = pkgs.niri-unstable;
      settings = {
        clipboard.disable-primary = true;
        prefer-no-csd = true;

        spawn-at-startup = [
          {command = ["xsettingsd"];}
          {command = ["${pkgs.wl-gammarelay-rs}/bin/wl-gammarelay-rs"];}
        ];

        environment = {
          QT_QPA_PLATFORM = "wayland";
          DISPLAY = ":0";
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
            gap = 2;
            place-within-column = true;
            corner-radius = 5;
            gaps-between-tabs = 5;
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
                title = "^notificationtoasts_\d+_desktop$";
              }
            ];
            default-floating-position = {
              relative-to = "bottom-right";
              x = 10;
              y = 10;
            };
            open-floating = true;
          }
          {
            matches = [
              {app-id = "[Ss]potify";}
            ];
            open-on-workspace = "music";
          }
        ];
      };
    };
  };

  # Might need to change this idk.
  # Only used bc xwayland-satellite makes applications HUUUGE
  xdg.configFile."xsettingsd/xsettingsd.conf" = {
    text = ''
      Gdk/WindowScalingFactor 1
      Gdk/UnscaledDPI 122880
    '';
  };
}
