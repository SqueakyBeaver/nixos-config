{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "desktop";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    niri.enable = mkEnableOption "Use the niri compositor";
  };

  config = mkIf cfg.niri.enable {
    programs.niri.enable = true;

    stylix.enable = true;

    # Some nice packages to have
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite-unstable
      swaybg
    ];
  };
}
