# Shamelessly copied from shodiboo
{
  lib,
  pkgs,
  config,
  ...
}: let
  icons = rec {
    calendar = "󰃭 ";
    clock = " ";
    battery.charging = "󱐋";
    battery.horizontal = [" " " " " " " " " "];
    battery.vertical = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    battery.levels = battery.vertical;
    network.disconnected = "󰤮 ";
    network.ethernet = "󰈀 ";
    network.strength = ["󰤟 " "󰤢 " "󰤥 " "󰤨 "];
    bluetooth.on = "󰂯";
    bluetooth.off = "󰂲";
    bluetooth.battery = "󰥉";
    volume.source = "󱄠";
    volume.muted = "󰝟";
    volume.levels = ["󰕿" "󰖀" "󰕾"];
    idle.on = "󰈈 ";
    idle.off = "󰈉 ";
    vpn = "󰌆 ";

    notification.red_badge = "<span foreground='red'><sup></sup></span>";
    notification.bell = "󰂚";
    notification.bell-badge = "󱅫";
    notification.bell-outline = "󰂜";
    notification.bell-outline-badge = "󰅸";
  };
in {
  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.gammastep
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  programs.waybar.settings.mainBar = {
    layer = "top";
    modules-left = ["wireplumber" "wireplumber#source" "idle_inhibitor"];
    modules-center = ["clock#date" "clock"];
    modules-right = ["tray" "backlight" "network" "bluetooth" "bluetooth#battery" "battery" "custom/swaync"];

    tray = {
      icon-size = 21;
      spacing = 10;
    };

    battery = {
      interval = 5;
      format = "{icon}  {capacity}%";
      format-charging = "{icon}  {capacity}% ${icons.battery.charging}";
      format-icons = icons.battery.levels;
      states.warning = 30;
      states.critical = 15;
    };

    clock = {
      interval = 1;
      format = "${icons.clock} {:%H:%M:%S}";
      actions = {
        on-scroll-up = "tz_up";
        on-scroll-down = "tz_down";
      };
    };

    "clock#date" = {
      format = "${icons.calendar} {:%d-%b-%Y}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        on-scroll = 1;
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        # Touchpad scrolling sucks tbh
        on-click = "shift_up";
        on-click-left = "shift_down";
        on-click-middle = "mode";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };

    backlight = {
      device = "";
      format = "<span font='12'>{icon}</span>";
      states = {
      };
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
      on-scroll-down = "brightnessctl s 5%-";
      on-scroll-up = "brightnessctl s 5%+";
      on-click-middle = "sh ${./gammastep_toggle.sh} -t 5000";
      smooth-scrolling-threshold = 1;
    };

    network = {
      tooltip-format = "{ifname}";
      format-disconnected = icons.network.disconnected;
      format-ethernet = icons.network.ethernet;
      format-wifi = "{icon} {essid}";
      format-icons = icons.network.strength;
      on-click = "networkmanager_dmenu";
    };

    bluetooth = {
      format = "{icon}";
      format-disabled = "";
      format-icons = {
        inherit (icons.bluetooth) on off;
        connected = icons.bluetooth.on;
      };
      format-connected = "{icon} {device_alias}";
      on-click = "networkmanager_dmenu";
    };
    "bluetooth#battery" = {
      format = "";
      format-connected-battery = "${icons.bluetooth.battery} {device_battery_percentage}%";
    };

    wireplumber = {
      format = "{icon} {volume}%";
      format-muted = "${icons.volume.muted} {volume}%";
      format-icons = icons.volume.levels;
      reverse-scrolling = 1;
      tooltip = false;
    };

    "wireplumber#source" = {
      format = "${icons.volume.source} {node_name}";
      tooltip = false;
    };

    # "group/volume" = {
    #   orientation = "horizontal";
    #   modules = [
    #     "wireplumber"
    #     "wireplumber#source"
    #   ];
    #   drawer = {
    #     transition-left-to-right = true;
    #   };
    # };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = icons.idle.on;
        deactivated = icons.idle.off;
      };
    };

    "custom/swaync" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = icons.notification.bell-outline;
        none-cc-open = icons.notification.bell;
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      # exec = ''swaync-client -swb | jq -c 'if .class | .[]? // . | contains("cc-open") then .alt += "-cc-open" else . end' '';
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };

  stylix.targets.waybar.enable = false;
  programs.waybar.style = let
    colors = config.lib.stylix.colors;
    modules = s: "${s ".modules-left"}, ${s ".modules-center"}, ${s ".modules-right"}";
    module = s: modules (m: "${m} > ${s} > *");
  in ''
    * {
        border: none;
        font-family: ${config.stylix.fonts.sansSerif.name};
        font-size: ${toString config.stylix.fonts.sizes.desktop}px;
        color: #${colors.base07};
    }

    window#waybar {
        background: transparent;
        font-size: 1em;
    }

    ${modules lib.id} {
        background: transparent;
        margin: 0px 5px;
    }

    ${module "*"} {
      margin: 0px 1px;
      padding: 3px 5px;
      background: #${colors.base00};
    }
    ${module ":first-child"} {
        padding-left: 10px;
        border-top-left-radius: 20px;
        border-bottom-left-radius: 20px;
    }

    ${module ":last-child"} {
        padding-right: 10px;
        border-top-right-radius: 20px;
        border-bottom-right-radius: 20px;
    }

    ${module ":not(:first-child)"} {
        border-top-left-radius: 3px;
        border-bottom-left-radius: 3px;
    }

    ${module ":not(last-child)"} {
        border-top-right-radius: 3px;
        border-bottom-right-radius: 3px;
    }

    #wireplumber:not(.source).muted {
        color: #${colors.yellow};
    }

    #idle_inhibitor.activated {
      color: #${colors.yellow};
    }

    #battery.charging {
        color: #${colors.green};
    }

    #battery.warning:not(.charging) {
        color: #${colors.yellow};
    }

    #battery.critical:not(.charging) {
        animation: critical-blink steps(8) 1s infinite alternate;
    }

    @keyframes critical-blink {
        to {
            color: #${colors.red};
        }
    }
  '';
}
