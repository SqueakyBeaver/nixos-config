# Niri config for me :3
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./waybar.nix
    ./stylix.nix 
    ./binds.nix
    ../stylix.nix
  ];

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    rofimoji
    xsettingsd
  ];

  services.swaync.enable = true;
  services.cliphist.enable = true;

  services.swayidle = {
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

  programs = {
    fuzzel.enable = true;
    alacritty.enable = true;
    swaylock.enable = true;
    wlogout.enable = true;

    niri.settings = {
      clipboard.disable-primary = true;
      prefer-no-csd = true;

      spawn-at-startup = [
        {
          command = ["sh" "-c" "xwayland-satellite & { sleep 1; xsettingsd; } &"];
        }
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

  # Might need to change this idk.
  # Only used bc xwayland-satellite makes applications HUUUGE
  xdg.configFile."xsettingsd/xsettingsd.conf" = {
    text = ''
      Gdk/WindowScalingFactor 1
      Gdk/UnscaledDPI 122880
    '';
  };
}
