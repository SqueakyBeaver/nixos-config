{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime-legacy1
      intel-vaapi-driver
      intel-ocl
    ];
  };

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
  };
}
