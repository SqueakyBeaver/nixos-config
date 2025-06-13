{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  module = "db";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable the mariadb database service
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      settings = {
        mysqld = {
          lower_case_table_names = 1;
        };
      };
    };
  };
}
