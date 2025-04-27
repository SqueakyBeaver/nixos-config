{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: {} /*
with lib; let
  module = "desktop";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    niri.enable = mkEnableOption "Use the niri compositor";
  };

  config = mkIf cfg.niri.enable {
    programs.niri.enable = true;
    services.xserver.displayManager.gdm = {
      enable = true;
    };

    stylix.enable = true;
    stylix.image = pkgs.fetchurl {
      url = "https://sonic.sega.jp/SonicChannel/upload_images/wallpaper_243_knuckles_19_pc.png";
      hash = "sha256-Yt1q9ynzmlGI21/Suhl4Ik4iXbvPlwb+YjdluIyt898=";
    };
    stylix.targets.plymouth.enable = false;

    programs.kdeconnect.enable = true;
    security.polkit.enable = true;

    systemd.user.services.niri-flake-polkit = lib.mkForce {
      description = "PolicyKit Authentication Agent provided by niri-flake";
      wantedBy = ["niri.service"];
      after = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    programs.dconf.enable = true;

    # Some nice packages to have
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite
      swaybg
      networkmanagerapplet
    ];
  };
}*/
