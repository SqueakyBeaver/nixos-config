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

  programs.noctalia-shell = {
    enable = true;
    # settings = {
    #
    #   plugins = {
    #     sources = [
    #       {
    #         enabled = true;
    #         name = "Official Noctalia Plugins";
    #         url = "https://github.com/noctalia-dev/noctalia-plugins";
    #       }
    #     ];
    #     states = {
    #       catwalk = {
    #         enabled = true;
    #         sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #       };
    #     };
    #     version = 2;
    #   };
    # };
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = ../../wall.png;
    };
  };
}
