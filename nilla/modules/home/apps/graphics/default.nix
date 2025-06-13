{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "graphics";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install graphics (drawing, etc.) programs
      '';
    };

    gimp.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install gimp
      '';
    };

    krita.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install krita
      '';
    };

    inkscape.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install inkscape
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (lib.mkIf cfg.gimp.enable pkgs.gimp)
      (lib.mkIf cfg.krita.enable pkgs.krita)
      (lib.mkIf cfg.inkscape.enable pkgs.inkscape)
    ];
  };
}
