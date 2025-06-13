{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "apps";
  appName = "obsidian";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install obsidian
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
}
