{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = [
    pkgs.fastfetch
  ];

  # qt = {
  #   platformTheme.name = "qtct";
  #   style.name = "breeze";
  # };

  programs.noctalia-shell = {
    enable = true;
    # settings = {
    #   bar = {
    #     barType = "simple";
    #     position = "top";
    #     marginVertical = 4;
    #     marginHorizontal = 4;
    #     frameRadius = 12;
    #     displayMode = "always_visible";
    #     widgets = {
    #       left = [
    #         {
    #           id = "Launcher";
    #           useDistroLogo = true;
    #         }
    #         {
    #           id = "Workspace";
    #         }
    #         {
    #           compactMode = true;
    #           id = "SystemMonitor";
    #         }
    #         {
    #           id = "ActiveWindow";
    #         }
    #         {
    #           id = "MediaMini";
    #         }
    #       ];
    #       center = [
    #         {
    #           formatHorizontal = "HH:mm dd MMM yyyy";
    #           formatVertical = "HH mm - dd MMM yyyy";
    #           id = "Clock";
    #           tooltipFormat = "HH:mm dd MMM yyyy";
    #         }
    #       ];
    #       right = [
    #         {
    #           colorizeIcons = true;
    #           hidePassive = false;
    #           id = "Tray";
    #         }
    #         {
    #           id = "plugin:kde-connect";
    #         }
    #         {
    #           id = "Microphone";
    #         }
    #         {
    #           id = "Volume";
    #         }
    #         {
    #           id = "Brightness";
    #         }
    #         {
    #           id = "NightLight";
    #         }
    #         {
    #           id = "Bluetooth";
    #         }
    #         {
    #           id = "Network";
    #         }
    #         {
    #           id = "KeepAwake";
    #         }
    #         {
    #           id = "Battery";
    #           showPowerProfiles = true;
    #         }
    #         {
    #           id = "ControlCenter";
    #         }
    #         {
    #           id = "NotificationHistory";
    #         }
    #       ];
    #     };
    #   };
    #   general = {
    #     lockOnSuspend = true;
    #     showSessionButtonsOnLockScreen = true;
    #     showHibernateOnLockScreen = true;
    #     enableLockScreenMediaControls = true;
    #     telemetryEnabled = false;
    #     clockStyle = "custom";
    #     clockFormat = "dd MMM yyyy";
    #     passwordChars = true;
    #   };
    #   ui = {
    #     tooltipsEnabled = true;
    #     scrollbarAlwaysVisible = true;
    #     translucentWidgets = true;
    #     panelsAttachedToBar = true;
    #     settingsPanelMode = "attached";
    #   };
    #   location = {
    #     useFahrenheit = true;
    #     use12hourFormat = false;
    #   };
    #   wallpaper = {
    #     enabled = true;
    #     overviewEnabled = true;
    #     overviewBlur = 0.4;
    #     overviewTint = 0.6;
    #   };
    #   appLauncher = {
    #     enableClipboardHistory = true;
    #     autoPasteClipboard = false;
    #     enableClipPreview = true;
    #     clipboardWrapText = true;
    #     enableClipboardSmartIcons = true;
    #     enableClipboardChips = true;
    #     clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
    #     clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
    #     position = "center";
    #     sortByMostUsed = true;
    #     terminalCommand = "alacritty -e";
    #     overviewLayer = true;
    #   };
    #   dock = {
    #     enabled = true;
    #     position = "bottom";
    #     displayMode = "auto_hide";
    #     dockType = "floating";
    #     pinnedApps = ["app.zen_browser.zen"];
    #     pinnedStatic = true;
    #     inactiveIndicators = true;
    #     groupApps = true;
    #     groupContextMenuMode = "extended";
    #     groupClickAction = "list";
    #     groupIndicatorStyle = "dots";
    #     showDockIndicator = true;
    #     indicatorThickness = 6;
    #     indicatorColor = "primary";
    #     indicatorOpacity = 0.8;
    #   };
    #   sessionMenu = {
    #     powerOptions = [
    #       {
    #         action = "lock";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "1";
    #       }
    #       {
    #         action = "suspend";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "2";
    #       }
    #       {
    #         action = "hibernate";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "3";
    #       }
    #       {
    #         action = "reboot";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "4";
    #       }
    #       {
    #         action = "logout";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "5";
    #       }
    #       {
    #         action = "shutdown";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "6";
    #       }
    #       {
    #         action = "rebootToUefi";
    #         command = "";
    #         countdownEnabled = true;
    #         enabled = true;
    #         keybind = "7";
    #       }
    #     ];
    #   };
    #   notifications = {
    #     enabled = true;
    #     enableMarkdown = true;
    #     location = "top_right";
    #     overlayLayer = true;
    #   };
    #   osd = {
    #     enabled = true;
    #     location = "bottom";
    #     overlayLayer = true;
    #   };
    #   colorSchemes = {
    #     useWallpaperColors = true;
    #     predefinedScheme = "Noctalia (default)";
    #     darkMode = true;
    #     generationMethod = "rainbow"; # gay :3
    #   };
    #   templates = {
    #     activeTemplates = lib.mkIf (!(config ? stylix
    #       && config.stylix.enable)) [
    #       {
    #         enabled = true;
    #         id = "qt";
    #       }
    #       {
    #         enabled = true;
    #         id = "gtk";
    #       }
    #       {
    #         enabled = true;
    #         id = "zenBrowser";
    #       }
    #       {
    #         enabled = true;
    #         id = "niri";
    #       }
    #       {
    #         enabled = true;
    #         id = "alacritty";
    #       }
    #       {
    #         enabled = true;
    #         id = "kcolorscheme";
    #       }
    #     ];
    #     enableUserTheming = false;
    #   };
    #   nightLight = {
    #     enabled = true;
    #     forced = false;
    #     autoSchedule = true;
    #     nightTemp = "4000";
    #     dayTemp = "6500";
    #     manualSunrise = "06:30";
    #     manualSunset = "18:30";
    #   };
    #   idle = {
    #     enabled = true;
    #     screenOffTimeout = 600;
    #     lockTimeout = 660;
    #     suspendTimeout = 1800;
    #   };
    # };
    # plugins = {
    #   sources = [
    #     {
    #       enabled = true;
    #       name = "Official Noctalia Plugins";
    #       url = "https://github.com/noctalia-dev/noctalia-plugins";
    #     }
    #   ];
    #   states = {
    #     catwalk = {
    #       enabled = true;
    #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #     };
    #     kde-connect = {
    #       enable = true;
    #       sourceUrl = "https://github.com/WerWolv/noctalia-kde-connect";
    #     };
    #   };
    #   version = 2;
    # };
    # pluginSettings = {
    #   catwalk = {
    #     minimumThreshold = 25;
    #     hideBackground = true;
    #   };
    #   kde-connect = {
    #   };
    # };
  };

  # home.file.".cache/noctalia/wallpapers.json" = {
  #   text = builtins.toJSON {
  #     defaultWallpaper = ../../wall.png;
  #   };
  # };
}
