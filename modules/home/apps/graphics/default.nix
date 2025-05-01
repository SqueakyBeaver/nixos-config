{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "graphics";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install graphics (drawing, etc.) programs
      '';
    };

    gimp.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install gimp
      '';
    };

    krita.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install krita
      '';
    };

    inkscape.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install inkscape
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (mkIf cfg.gimp.enable pkgs.gimp)
      (mkIf cfg.krita.enable pkgs.krita)
      (mkIf cfg.inkscape.enable pkgs.inkscape)
    ];
  };
}
