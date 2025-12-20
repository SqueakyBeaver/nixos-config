{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./keybinds.nix
  ];

  # qt.platformTheme.name = lib.mkForce "kde";

  programs.plasma = {
    enable = true;

    desktop = {
      icons = {
        previewPlugins = [
          "audiothumbnail"
          "fontthumbnail"
        ];
      };
    };

    # TODO: Add homelab touchpad and other mice if I feel like it
    input.mice = [
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
    input.touchpads = [
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

    kwin = {
      effects = {
        blur = {
          enable = true;
          strength = 8;
        };
        cube.enable = true;
        desktopSwitching.animation = "slide";
        dimAdminMode.enable = true;
        minimization.animation = "squash";
        shakeCursor.enable = true;
        wobblyWindows.enable = true;
      };
      nightLight = {
        enable = true;
        mode = "constant";
        temperature.day = 4500;
        temperature.night = 5000;
        time = {
          evening = "20:00";
          morning = "08:00";
        };
      };

      scripts = {
      };

      titlebarButtons.left = ["on-all-desktops" "keep-above-windows"];
      titlebarButtons.right = ["minimize" "maximize" "close"];
    };
  };
}
