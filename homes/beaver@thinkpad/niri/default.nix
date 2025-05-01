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
  ];

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    rofimoji
  ];

  services.swaync.enable = true;
  services.cliphist.enable = true;

  services.swayosd = {
    enable = true;
  };

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
        timeout = 300;
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
          command = ["xwayland-satellite"];
        }
      ];

      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
      };

      input = {
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

          # { fixed = 1920; }
        ];

        tab-indicator = {
          corner-radius = 5;
        };

        gaps = 10;
      };

      workspaces = {
        main = {};
        chat = {};
        music = {};
      };

      window-rules = [
        {
          matches = [
            {app-id = "[Ll]egcord";}
          ];

          open-on-workspace = "chat";
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
}
