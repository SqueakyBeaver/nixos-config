{
  lib,
  config,
  ...
}:
with lib; let
  module = "tor";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable tor services (currently just snowflake proxy)";
    };
    snowflake.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to run a snowflake proxy on this device
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.snowflake-proxy = lib.mkIf cfg.snowflake.enable {
      enable = true;
      capacity = 10;
    };
  };
}
