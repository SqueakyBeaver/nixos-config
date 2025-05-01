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
    enable = mkEnableOption "Enable tor services (currently just snowflake proxy)";
    snowflake.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to run a snowflake proxy on this device
      '';
    };
  };

  config = mkIf cfg.enable {
    services.snowflake-proxy = mkIf cfg.snowflake.enable {
      enable = true;
      capacity = 10;
    };
  };
}
