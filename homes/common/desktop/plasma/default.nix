{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./inputMethods.nix
  ];

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
