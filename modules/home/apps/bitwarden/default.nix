{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "bitwarden";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install bitwarden
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bitwarden
    ];
  };
}
