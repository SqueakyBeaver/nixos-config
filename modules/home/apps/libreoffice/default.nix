{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "libreoffice";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install libreoffice-qt
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.libreoffice-qt
    ];
  };
}
