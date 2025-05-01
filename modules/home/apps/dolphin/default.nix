{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "dolphin";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install dolphin
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dolphin-emu
    ];
  };
}
