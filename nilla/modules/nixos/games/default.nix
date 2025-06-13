{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "games";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Game module";
    };

    optimize = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        set the same sysctl settings as are set on SteamOS
      '';
    };

    steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Steam";
    };

    lutris.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Lutris";
    };

    mangohud.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "MangoHUD";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = lib.mkIf cfg.steam.enable {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      extraCompatPackages = [
        pkgs.proton-ge-bin
        pkgs.dotnet-sdk # For tmodloader
      ];
    };

    hardware.xpadneo.enable = true;

    environment.systemPackages = [
      (lib.mkIf cfg.lutris.enable (pkgs.lutris.override {
        extraLibraries = pkgs: [
          pkgs.libthai
        ];
        extraPkgs = pkgs: [
          pkgs.xemu
        ];
      }))
      (lib.mkIf cfg.mangohud.enable pkgs.mangohud)
      pkgs.steamtinkerlaunch # Not gonna set an option bc I'm lazy rn
      pkgs.protonup-qt
    ];

    hardware.graphics.enable32Bit = cfg.lutris.enable;

    programs.gamemode.enable = true;
  };
}
