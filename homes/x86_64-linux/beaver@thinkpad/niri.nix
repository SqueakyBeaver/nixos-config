# Niri config for me :3
{
  pkgs,
  config,
  ...
}: {
}
/*
  home.packages = with pkgs; [
    alacritty
    fuzzel
  ];

  services.swaync.enable = true;

  programs = {
    niri.settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            options = "caps:backspace";
          };
        };

        touchpad = {
          accel-profile = "flat";
          accel-speed = 0.20;
          click-method = "clickfiner";
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
          {proportion = 1 / 3;}
          {proportion = 1 / 2;}
          {proportion = 2 / 3;}

          # { fixed = 1920; }
        ];
        preset-column-heights = [
          {proportion = 1 / 3;}
          {proportion = 1 / 2;}
          {proportion = 2 / 3;}

          # { fixed = 1080; }
        ];

        tab-indicator = {
          corner-radius = 5;
        };

        prefer-no-csd = true;

        clipboard.disable-primary = true;

        workspaces = {
          main = {};
          chat = {};
          music = {};
        };

        window-rules = {
          legcord = {
            matches = {
              app-id = "[Ll]egcord";
            };

            open-on-workspace = "chat";
          };

          spotify = {
            matches = {
              app-id = "[Ss]potify";
            };

            open-on-workspace = "music";
          };
        };

        
      };
    };
  };
}
*/