{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "bitwarden";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install bitwarden
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bitwarden
    ];
  };
}
