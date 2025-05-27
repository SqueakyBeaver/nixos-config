{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  module = "games";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkEnableOption "Game module";
    optimize = lib.mkEnableOption ''
      set the same sysctl settings as are set on SteamOS
    '';
    steam.enable = mkEnableOption "Steam";
    lutris.enable = mkEnableOption "Lutris";
    mangohud.enable = mkEnableOption "MangoHUD";
  };

  config = mkIf cfg.enable {
    programs.steam = mkIf cfg.steam.enable {
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
    # My controller is fucky and requires this for rumble
    # Also idk which will work
    # boot.extraModprobeConfig = ''
    #   options hid_xpadneo quirks=30:a6:a4:a8:de:67+6
    #   options hid_xpadneo quirks=3E:42:6C:30:a6:a4:a8:de:67+6
    #   options hid_xpadneo quirks=3E:42:6C:a8:de:67+6

    # '';

    # services.udev.packages = [pkgs.steam-devices-udev-rules pkgs.game-devices-udev-rules];

    environment.systemPackages = [
      (mkIf cfg.lutris.enable (pkgs.lutris.override {
        extraLibraries = pkgs: [
          pkgs.libthai
        ];
        extraPkgs = pkgs: [
          pkgs.xemu
        ];
      }))
      (mkIf cfg.mangohud.enable pkgs.mangohud)
      pkgs.steamtinkerlaunch # Not gonna set an option bc I'm lazy rn
      pkgs.protonup-qt
    ];

    hardware.graphics.enable32Bit = cfg.lutris.enable;

    programs.gamemode.enable = true;
  };
}
