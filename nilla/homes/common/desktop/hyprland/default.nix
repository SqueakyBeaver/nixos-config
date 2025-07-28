{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprpanel.nix
  ];

  home.packages = [
    pkgs.fuzzel
    pkgs.brightnessctl
    pkgs.rofimoji
    pkgs.xsettingsd
  ];

  programs = {
    hyprlock.enable = true;
    wlogout.enable = true;
  };

  services = {
    hyprpolkitagent.enable = true;
    hyprpaper.enable = true;
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    hyprsunset = {
      enable = true;
      transitions = {
        sunrise = {
          calendar = "*-*-* 09:30:00";
          requests = [
            ["identity" "true"]
          ];
        };
        sunset = {
          calendar = "*-*-* 19:30:00";
          requests = [
            ["temperature" "5000"]
          ];
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # Conflicts with uwsm
    # systemd.enable = false;
    xwayland.enable = true;
    systemd.variables = ["--all"];

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "fuzzel";

      env = [
        "QT_QPA_PLATFORM,wayland"
      ];

      monitor = "eDP-1, 1920x1080@60, 0x0, 1.25";

      general = {
        gaps_out = 5;
        resize_on_border = true;
        layout = "scrolling";
      };

      decoration = {
        rounding = 7;
      };

      input = {
        kb_options = "caps:backspace";
        accel_profile = "flat";
        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
        };
      };

      device = [
        {
          name = "synps/2-synaptics-touchpad";
          sensitivity = 0.5;
        }
      ];

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        middle_click_paste = false;
      };

      xwayland = {
        create_abstract_socket = true;
      };

      render = {
        new_render_scheduling = true;
      };

      ecosystem = {
        no_donation_nag = true;
      };

      animation = [
        "workspaces, 1, 8, default, slidevert"
      ];

      plugins = {
        hyprexpo = {
          columns = 1;
        };
        dynamic-cursors = {
          mode = "none";
        };
      };
    };

    plugins = with pkgs.hyprlandPlugins; [
      hyprscrolling
      hyprexpo
      hypr-dynamic-cursors
    ];
  };
  # Might need to change this idk.
  # Gdk likes to make everything really beeg
  xdg.configFile."xsettingsd/xsettingsd.conf" = {
    text = ''
      Gdk/WindowScalingFactor 1
      Gdk/UnscaledDPI 122880
    '';
  };
}
