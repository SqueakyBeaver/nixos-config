{
  config,
  pkgs,
  ...
}: {
  programs.plasma = {
    input = {
      mice = [
        {
          name = "ELECOM TrackBall Mouse HUGE TrackBall";
          vendorId = "056e";
          productId = "010d";
          enable = true;
          accelerationProfile = "default";
        }
        {
          name = "TPPS/2 Elan TrackPoint";
          vendorId = "0002";
          productId = "000a";
          enable = true;
          accelerationProfile = "none";
          acceleration = 0;
        }
      ];
      touchpads = [
        {
          name = "SynPS/2 Synaptics TouchPad";
          vendorId = "0002";
          productId = "0007";
          enable = true;
          accelerationProfile = "none";
          naturalScroll = true;
          pointerSpeed = 0.200;
          disableWhileTyping = false;
          rightClickMethod = "twoFingers";
          scrollMethod = "twoFingers";
          scrollSpeed = 1;
          tapAndDrag = true;
          tapToClick = true;
          twoFingerTap = "rightClick";
        }
      ];
      keyboard.options = [
        "caps:backspace"
        "shift:both_capslock"
      ];
    };

    shortcuts = {
      kmix.decrease_microphone_volume = "Microphone Volume Down";
      kmix.decrease_volume = "Volume Down";
      kmix.decrease_volume_small = "Shift+Volume Down";
      kmix.increase_microphone_volume = "Microphone Volume Up";
      kmix.increase_volume = "Volume Up";
      kmix.increase_volume_small = "Shift+Volume Up";
      kmix.mic_mute = ["Microphone Mute" "Meta+Volume Mute"];
      ksmserver."Log Out" = "Ctrl+Alt+Del";
      kwin.Cube = "Meta+Shift+C";
      kwin."Grid View" = "Meta+G";
      kwin.Overview = "Meta+W";
      kwin."Show Desktop" = "Meta+M";
      kwin."Switch to Next Desktop" = "Meta+U";
      kwin."Switch to Previous Desktop" = "Meta+I";
      kwin."Window Close" = "Meta+Q";
      kwin."Window Fullscreen" = "Meta+Shift+F";
      kwin."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      kwin."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      kwin."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      kwin."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      kwin."Window to Next Desktop" = "Meta+Ctrl+U";
      kwin."Window to Previous Desktop" = "Meta+Ctrl+I";
      kwin.disableInputCapture = "Meta+Shift+Esc";
      kwin.karousel-column-move-end = "Meta+Ctrl+Shift+End";
      kwin.karousel-column-move-left = "Meta+Ctrl+H";
      kwin.karousel-column-move-right = "Meta+Ctrl+L";
      kwin.karousel-column-move-start = "Meta+Ctrl+Shift+Home";
      kwin.karousel-column-move-to-column-1 = "Meta+Ctrl+Shift+1";
      kwin.karousel-column-move-to-column-2 = "Meta+Ctrl+Shift+2";
      kwin.karousel-column-move-to-column-3 = "Meta+Ctrl+Shift+3";
      kwin.karousel-column-move-to-column-4 = "Meta+Ctrl+Shift+4";
      kwin.karousel-column-move-to-column-5 = "Meta+Ctrl+Shift+5";
      kwin.karousel-column-move-to-column-6 = "Meta+Ctrl+Shift+6";
      kwin.karousel-column-move-to-column-7 = "Meta+Ctrl+Shift+7";
      kwin.karousel-column-move-to-column-8 = "Meta+Ctrl+Shift+8";
      kwin.karousel-column-move-to-column-9 = "Meta+Ctrl+Shift+9";
      kwin.karousel-column-move-to-desktop-1 = "Meta+Ctrl+Shift+F1";
      kwin.karousel-column-move-to-desktop-10 = "Meta+Ctrl+Shift+F10";
      kwin.karousel-column-move-to-desktop-11 = "Meta+Ctrl+Shift+F11";
      kwin.karousel-column-move-to-desktop-12 = "Meta+Ctrl+Shift+F12";
      kwin.karousel-column-move-to-desktop-2 = "Meta+Ctrl+Shift+F2";
      kwin.karousel-column-move-to-desktop-3 = "Meta+Ctrl+Shift+F3";
      kwin.karousel-column-move-to-desktop-4 = "Meta+Ctrl+Shift+F4";
      kwin.karousel-column-move-to-desktop-5 = "Meta+Ctrl+Shift+F5";
      kwin.karousel-column-move-to-desktop-6 = "Meta+Ctrl+Shift+F6";
      kwin.karousel-column-move-to-desktop-7 = "Meta+Ctrl+Shift+F7";
      kwin.karousel-column-move-to-desktop-8 = "Meta+Ctrl+Shift+F8";
      kwin.karousel-column-move-to-desktop-9 = "Meta+Ctrl+Shift+F9";
      kwin.karousel-column-toggle-stacked = "Meta+X";
      kwin.karousel-column-width-decrease = "Meta+-";
      kwin.karousel-column-width-increase = "Meta+=";
      kwin.karousel-column-width-maximize = "Meta+F";
      kwin.karousel-focus-down = "Meta+J";
      kwin.karousel-focus-end = "Meta+End";
      kwin.karousel-focus-left = "Meta+H";
      kwin.karousel-focus-next = "Meta+]";
      kwin.karousel-focus-previous = "Meta+[";
      kwin.karousel-focus-right = "Meta+L";
      kwin.karousel-focus-start = "Meta+Home";
      kwin.karousel-focus-up = "Meta+K";
      kwin.karousel-grid-scroll-end = "Meta+Alt+End";
      kwin.karousel-grid-scroll-focused = "Meta+C";
      kwin.karousel-grid-scroll-left = "Meta+Alt+PgUp";
      kwin.karousel-grid-scroll-left-column = "Meta+Alt+A";
      kwin.karousel-grid-scroll-right = "Meta+Alt+PgDown";
      kwin.karousel-grid-scroll-right-column = "Meta+Alt+D";
      kwin.karousel-grid-scroll-start = "Meta+Alt+Home";
      kwin.karousel-screen-switch = "Meta+Ctrl+Return";
      kwin.karousel-tail-move-to-desktop-1 = "Meta+Ctrl+Alt+Shift+F1";
      kwin.karousel-tail-move-to-desktop-10 = "Meta+Ctrl+Alt+Shift+F10";
      kwin.karousel-tail-move-to-desktop-11 = "Meta+Ctrl+Alt+Shift+F11";
      kwin.karousel-tail-move-to-desktop-12 = "Meta+Ctrl+Alt+Shift+F12";
      kwin.karousel-tail-move-to-desktop-2 = "Meta+Ctrl+Alt+Shift+F2";
      kwin.karousel-tail-move-to-desktop-3 = "Meta+Ctrl+Alt+Shift+F3";
      kwin.karousel-tail-move-to-desktop-4 = "Meta+Ctrl+Alt+Shift+F4";
      kwin.karousel-tail-move-to-desktop-5 = "Meta+Ctrl+Alt+Shift+F5";
      kwin.karousel-tail-move-to-desktop-6 = "Meta+Ctrl+Alt+Shift+F6";
      kwin.karousel-tail-move-to-desktop-7 = "Meta+Ctrl+Alt+Shift+F7";
      kwin.karousel-tail-move-to-desktop-8 = "Meta+Ctrl+Alt+Shift+F8";
      kwin.karousel-tail-move-to-desktop-9 = "Meta+Ctrl+Alt+Shift+F9";
      kwin.karousel-window-move-down = "Meta+Shift+J";
      kwin.karousel-window-move-end = "Meta+Shift+End";
      kwin.karousel-window-move-next = "Meta+}";
      kwin.karousel-window-move-previous = "Meta+{";
      kwin.karousel-window-move-start = "Meta+Shift+Home";
      kwin.karousel-window-move-to-column-1 = "Meta+Shift+1";
      kwin.karousel-window-move-to-column-2 = "Meta+Shift+2";
      kwin.karousel-window-move-to-column-3 = "Meta+Shift+3";
      kwin.karousel-window-move-to-column-4 = "Meta+Shift+4";
      kwin.karousel-window-move-to-column-5 = "Meta+Shift+5";
      kwin.karousel-window-move-to-column-6 = "Meta+Shift+6";
      kwin.karousel-window-move-to-column-7 = "Meta+Shift+7";
      kwin.karousel-window-move-to-column-8 = "Meta+Shift+8";
      kwin.karousel-window-move-to-column-9 = "Meta+Shift+9";
      kwin.karousel-window-move-up = "Meta+Shift+K";
      kwin.karousel-window-toggle-floating = "Meta+Space";
      mediacontrol.nextmedia = ["Media Next" "Touchpad Off"];
      mediacontrol.pausemedia = "Media Pause";
      mediacontrol.playpausemedia = ["Media Play" "Favorites"];
      mediacontrol.previousmedia = ["Media Previous" "Touchpad On"];
      mediacontrol.seekbackwardmedia = "Media Rewind";
      mediacontrol.seekforwardmedia = "Media Fast Forward";
      mediacontrol.stopmedia = ["Media Stop" "Touchpad Toggle"];
      "org.kde.konsole".autofill_login = "Ctrl+Shift+L";
      "org.kde.konsole".generate_password = "Ctrl+Shift+9";
      plasmashell.clipboard_action = "Meta+Ctrl+X";
      plasmashell.show-on-mouse-pos = "Meta+V";
      "services/Alacritty.desktop"._launch = ["Ctrl+Alt+T" "Meta+T"];
      "services/org.kde.krunner.desktop"._launch = "Meta+D";
      "services/org.kde.spectacle.desktop".RectangularRegionScreenShot = "Print";
      "services/org.kde.spectacle.desktop"._launch = "Meta+Shift+S";
      "services/systemsettings.desktop"._launch = ["Tools" "Meta+,"];
    };

    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
      launch = "Meta+Shift+S";
    };

    krunner.shortcuts = {
      launch = "Meta+D";
    };
  };
}
