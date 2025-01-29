{
  config,
  lib,
  ...
}:
# TODO Add to readme (am lazy)
with lib; let
  module = "adb";
  cfg = config.${module};
in {
  options.${module} = {
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
