{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
with lib; let
  module = "db";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to enable the mariadb database service
      '';
    };
  };

  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
