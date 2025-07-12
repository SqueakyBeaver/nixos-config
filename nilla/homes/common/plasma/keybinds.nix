{
  config,
  pkgs,
  ...
}: {
  programs.plasma = {
    shortcuts = {
      kaccess."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      kmix = {
        "decrease_microphone_volume" = "Microphone Volume Down";
        "decrease_volume" = "Volume Down";
        "decrease_volume_small" = "Shift+Volume Down";
        "increase_microphone_volume" = "Microphone Volume Up";
        "increase_volume" = "Volume Up";
        "increase_volume_small" = "Shift+Volume Up";
        "mic_mute" = ["Microphone Mute" "Meta+Volume Mute"];
        "mute" = "Volume Mute";
      };
      "ksmserver"."Log Out" = "Ctrl+Alt+Del";
      kwin = {
        "Cube" = "Meta+Shift+C";
        "Grid View" = "Meta+G";
        "Overview" = "Meta+W";
        "Show Desktop" = "Meta+M";
        "Switch to Next Desktop" = "Meta+U";
        "Switch to Previous Desktop" = "Meta+I";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Window Close" = "Meta+Q";
        "Window Fullscreen" = "Meta+Shift+F";
        "Window Maximize" = "Meta+F";
        "Window to Next Desktop" = "Meta+Ctrl+U";
        "Window to Previous Desktop" = "Meta+Ctrl+I";
        "karousel-column-move-end" = "Meta+Ctrl+Shift+End";
        "karousel-column-move-left" = "Meta+Ctrl+H";
        "karousel-column-move-right" = "Meta+Ctrl+L";
        "karousel-column-move-start" = "Meta+Ctrl+Shift+Home";
        "karousel-column-toggle-stacked" = "Meta+X";
        "karousel-column-width-decrease" = "Meta+-";
        "karousel-column-width-increase" = "Meta+=";
        "karousel-focus-down" = "Meta+J";
        "karousel-focus-left" = "Meta+H";
        "karousel-focus-next" = "Meta+]";
        "karousel-focus-previous" = "Meta+[";
        "karousel-focus-right" = "Meta+L";
        "karousel-focus-up" = "Meta+K";
        "karousel-window-move-down" = "Meta+Shift+J";
        "karousel-window-move-next" = "Meta+}";
        "karousel-window-move-previous" = "Meta+{";
        "karousel-window-move-up" = "Meta+Shift+K";
        "karousel-window-toggle-floating" = "Meta+Space";
        "view_zoom_in" = "Meta+=";
        "view_zoom_out" = "Meta+_";
      };
      "services/Alacritty.desktop"."_launch" = ["Meta+T" "Ctrl+Alt+T"];
    };

    input.keyboard.options = [
      "caps:backspace"
    ];

    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
      launch = "Meta+Shift+S";
    };

    krunner.shortcuts = {
      launch = "Meta+D";
    };
  };
}
