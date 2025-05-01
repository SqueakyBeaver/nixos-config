{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "obsidian";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install obsidian
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
}
