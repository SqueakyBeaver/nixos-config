# Niri config for me :3
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./waybar.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    alacritty
    fuzzel
  ];

  services.swaync.enable = true;

  programs = {
    swaylock.enable = true;

    niri.settings = {
      clipboard.disable-primary = true;
      prefer-no-csd = true;

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
