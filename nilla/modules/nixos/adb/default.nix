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
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable adb";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
  };
}
