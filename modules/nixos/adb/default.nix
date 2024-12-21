{
  config,
  lib,
  namespace,
  ...
}:
# TODO Add to readme (am lazy)
with lib; let
  module = "adb";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable adb";
    };
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
  };
}
