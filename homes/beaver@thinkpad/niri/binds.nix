{
  config,
  lib,
  ...
}: {
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+T".action = spawn "alacritty";
      "Mod+D".action = spawn "fuzzel";
      "Super+Alt+L".action = spawn "swaylock";

      "Mod+V".action = spawn "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";

      "Mod+B".action = spawn "rofimoji";

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = ["brightnessctl" "s" "5%+"];
      };

      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = ["brightnessctl" "s" "5%-"];
      };

      "Mod+Q".action.close-window = {};

      "Mod+Space".action.toggle-window-floating = {};
      "Mod+W".action.toggle-column-tabbed-display = {};

      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+L".action.move-column-right = {};
      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};
      "Mod+Ctrl+Home".action.move-column-to-first = {};
      "Mod+Ctrl+End".action.move-column-to-last = {};

      "Mod+Shift+Left".action.focus-monitor-left = {};
      "Mod+Shift+Down".action.focus-monitor-down = {};
      "Mod+Shift+Up".action.focus-monitor-up = {};
      "Mod+Shift+Right".action.focus-monitor-right = {};
      "Mod+Shift+H".action.focus-monitor-left = {};
      "Mod+Shift+J".action.focus-monitor-down = {};
      "Mod+Shift+K".action.focus-monitor-up = {};
      "Mod+Shift+L".action.focus-monitor-right = {};

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+U".action.focus-workspace-down = {};
      "Mod+I".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
      "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

      "Mod+Shift+Page_Down".action.move-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-workspace-up = {};
      "Mod+Shift+U".action.move-workspace-down = {};
      "Mod+Shift+I".action.move-workspace-up = {};

      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action.focus-workspace-down = {};
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action.focus-workspace-up = {};
      };
      "Mod+Ctrl+WheelScrollDown" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-down = {};
      };
      "Mod+Ctrl+WheelScrollUp" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-up = {};
      };

      "Mod+WheelScrollRight".action.focus-column-right = {};
      "Mod+WheelScrollLeft".action.focus-column-left = {};
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};

      "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
      "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;
      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.reset-window-height = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+C".action.center-column = {};

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      "Mod+Shift+E".action.quit = {};

      "Mod+Shift+P".action.power-off-monitors = {};
    };
  };
}
